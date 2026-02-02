# Real-Time EKS Kafka Platform ![Terraform](https://img.shields.io/badge/Terraform-aws-blue) ![EKS](https://img.shields.io/badge/EKS-Kubernetes-blue) ![Kafka](https://img.shields.io/badge/Kafka-Strimzi-orange) ![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-blue)

---

## Overview

This project demonstrates a production-grade, real-time data platform on AWS using:

- **AWS EKS** (Elastic Kubernetes Service): Managed Kubernetes cluster
- **Terraform**: Infrastructure as Code for AWS networking, EKS, IAM, and remote state
- **Strimzi Kafka Operator**: Kubernetes-native management of Apache Kafka as a StatefulSet
- **Kafka UI (Explorer)**: Web UI for monitoring Kafka topics and messages
- **GitHub Actions**: CI/CD pipelines for infrastructure and application deployment
- **ECR** (Elastic Container Registry): Container image storage for backend and frontend
- **Node.js Backend**: REST API to produce messages to Kafka
- **React Frontend**: UI to send messages and visualize real-time flow

---

## Architecture Diagram

```
+-------------------+         +-------------------+         +-------------------+
|   React Frontend  | <-----> |   Node.js Backend | <-----> |      Kafka        |
| (LoadBalancer SVC)|         | (ClusterIP SVC)   |         | (Strimzi Operator)|
+-------------------+         +-------------------+         +-------------------+
        |                          |                                 |
        |                          |                                 |
        +--------------------------+---------------------------------+
                                   |
                             [EKS Cluster]
                                   |
                             [AWS VPC, IAM]
```

---

## Directory Structure

```
aws-devops/
├── eks-cluster.tf
├── main.tf
├── variables.tf
├── vpc.tf
├── README.md
├── README.html
├── apps/
│   ├── backend/
│   └── frontend/
├── helm/
│   └── kafka/
├── scripts/
│   └── create_ecr_repos.py
```

---

## Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-org/aws-devops.git
   cd aws-devops
   ```
2. **Provision AWS Infrastructure**
   ```bash
   terraform init
   terraform apply
   ```
3. **Deploy Kafka with Strimzi**
   ```bash
   kubectl apply -f helm/kafka/
   ```
4. **Build & Push Docker Images**
   ```bash
   cd apps/backend && docker build -t <ecr-backend-repo>:latest .
   cd ../frontend && docker build -t <ecr-frontend-repo>:latest .
   # Push to ECR after login
   ```
5. **Deploy Applications**
   ```bash
   kubectl apply -f apps/backend/k8s-deployment.yaml
   kubectl apply -f apps/frontend/k8s-deployment.yaml
   ```

---

## Features

- Automated AWS infrastructure provisioning with Terraform
- Secure, scalable EKS cluster
- Managed Kafka with Strimzi Operator
- CI/CD with GitHub Actions
- End-to-end demo: React frontend → Node.js backend → Kafka
- Easy local development and cloud deployment

---

