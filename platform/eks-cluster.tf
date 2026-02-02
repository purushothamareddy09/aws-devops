module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_version
  vpc_id          = aws_vpc.main.id
  subnet_ids      = aws_subnet.private[*].id
  enable_irsa     = true

  # Control plane logging
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  # Node group configuration
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    disk_size      = 50
    instance_types = ["t3.medium"]
    min_size       = 1
    max_size       = 3
    desired_size   = 2
  }

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 3
      desired_size = 2
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      labels = {
        role = "worker"
      }
    }
  }

  # Add EKS addons for production
  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {
      resolve_conflicts = "OVERWRITE"
    }
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
    aws-ebs-csi-driver = {
      resolve_conflicts = "OVERWRITE"
      service_account_role_arn = module.eks.eks_addon_iam_role_arn["aws-ebs-csi-driver"]
    }
  }

  irsa_service_accounts = {
    metrics_server = {
      namespace            = "kube-system"
      service_account_name = "metrics-server"
      attach_policy_arns   = [
        "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      ]
    }
  }

  tags = {
    Environment = "production"
    Terraform   = "true"
  }
}
