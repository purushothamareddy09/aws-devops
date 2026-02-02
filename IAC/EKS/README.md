# Real-Time EKS Kafka Platform with Terraform, GitHub Actions, and Fullstack Demo

## Overview
This project demonstrates a production-grade, real-time data platform on AWS using the following components:

- **AWS EKS (Elastic Kubernetes Service):** Managed Kubernetes cluster for scalable workloads
- **Terraform:** Infrastructure as Code for AWS networking, EKS, IAM, and remote state
- **Strimzi Kafka Operator:** Kubernetes-native management of Apache Kafka as a StatefulSet
- **Kafka UI (Explorer):** Web UI for monitoring Kafka topics and messages
- **GitHub Actions:** CI/CD pipelines for infrastructure and application deployment
- **ECR (Elastic Container Registry):** Container image storage for backend and frontend
- **Node.js Backend:** REST API to produce messages to Kafka
- **React Frontend:** UI to send messages and visualize real-time flow

---

## Architecture Diagram

```
+-------------------+         +-------------------+         +-------------------+
|   React Frontend  | <-----> |   Node.js Backend | <-----> |      Kafka        |
| (LoadBalancer SVC)|         | (ClusterIP SVC)   |         | (Strimzi Operator)|
+-------------------+         +-------------------+         +-------------------+
        |                          |                                 |
        |                          |                                 |
        |                +-------------------+                      |
        +--------------> |   Kafka UI (LB)   | <--------------------+
                         +-------------------+
```

- **User** interacts with the React frontend (exposed via AWS LoadBalancer Service)
- **Frontend** sends messages to the backend API (internal ClusterIP Service)
- **Backend** produces messages to Kafka (via Strimzi-managed brokers)
- **Kafka UI** (Kafka Explorer) is exposed via LoadBalancer for real-time topic/message inspection

---

## Technologies & Components

- **AWS VPC, Subnets, NAT, IGW:** Secure, multi-AZ networking for EKS
- **EKS Cluster:** Managed Kubernetes with private subnets, node groups, and IRSA
- **Terraform S3 Backend:** Remote state management
- **Strimzi Kafka Operator:** Helm-deployed, manages Kafka/Zookeeper as StatefulSets
- **Kafka UI:** Helm-deployed, public access via LoadBalancer
- **Node.js Backend:** Express API, KafkaJS for producing messages
- **React Frontend:** User input form, sends data to backend
- **ECR:** Stores Docker images for backend and frontend
- **GitHub Actions:**
  - Infrastructure pipeline (init, plan, apply, destroy)
  - Application pipeline (build, push, deploy backend/frontend)
  - Kafka pipeline (deploy Strimzi, Kafka cluster, Kafka UI)

---

## Flow
1. **Infrastructure Provisioning:**
   - Run Terraform pipeline to create VPC, EKS, IAM, S3 backend, etc.
2. **Kafka Platform Setup:**
   - Deploy Strimzi Operator and Kafka cluster via Helm
   - Deploy Kafka UI for topic/message inspection
3. **Application Deployment:**
   - Build and push backend/frontend Docker images to ECR
   - Deploy backend and frontend to EKS via manifests
4. **Real-Time Demo:**
   - User submits a message in the frontend
   - Frontend calls backend API, which produces the message to Kafka
   - Message appears in Kafka UI in real time

---

## How to Use

1. **Clone the repo and configure AWS credentials**
2. **Provision infrastructure:**
   - Run the Terraform GitHub Actions workflow (manual trigger)
3. **Deploy Kafka platform:**
   - Run the Kafka deployment workflow (manual trigger)
4. **Build and deploy applications:**
   - Run the build-and-deploy-apps workflow (manual trigger)
5. **Access the frontend and Kafka UI:**
   - Use the LoadBalancer DNS for the frontend and Kafka UI (output in workflow logs)
6. **Send messages and observe real-time flow in Kafka UI**

---

## Directory Structure
```
IAC/EKS/
  ├── vpc.tf, main.tf, variables.tf, eks-cluster.tf
  ├── helm/
  │    └── kafka/ (Strimzi chart, values, Kafka cluster manifest)
  ├── apps/
  │    ├── backend/ (Node.js app, Dockerfile, k8s manifest)
  │    └── frontend/ (React app, Dockerfile, k8s manifest)
  ├── scripts/
  │    └── create_ecr_repos.py
  └── .github/workflows/ (CI/CD pipelines)
```

---

## Security & Best Practices
- EKS nodes in private subnets
- IRSA for service accounts (metrics-server, EBS CSI)
- S3 remote state for Terraform
- Separate ECR repos for backend and frontend
- All deployments and services are managed via manifests and pipelines

---

## Credits
- [Strimzi Kafka Operator](https://strimzi.io/)
- [Kafka UI](https://github.com/provectus/kafka-ui)
- [Terraform AWS Modules](https://github.com/terraform-aws-modules)

---

## License
MIT
