variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "prod-eks-cluster"
}

variable "eks_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.29"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "tf_state_bucket" {
  description = "S3 bucket name for Terraform remote state"
  type        = string
  default     = "your-unique-terraform-state-bucket"
}

variable "tf_lock_table" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
  default     = "your-terraform-lock-table"
}
