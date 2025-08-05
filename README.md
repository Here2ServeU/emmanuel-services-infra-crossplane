# Emmanuel Services Cloud Infrastructure (Multi-Cloud DevOps Deployment)

## Overview

This project represents a real-world cloud deployment solution for **Emmanuel Services**, a company specializing in DevOps, Cloud Engineering, and AI-powered consulting services. The goal is to ensure global scalability, resilience, and observability of its customer-facing web application across **AWS**, **Azure**, and **GCP**.

This infrastructure-as-code setup enables Emmanuel Services to:
- Maintain consistent deployments using Helm and Kubernetes
- Enforce GitOps workflows via ArgoCD
- Monitor health and performance with Prometheus and Grafana
- Leverage Crossplane for managing infrastructure declaratively from within the cluster
- Onboard new team members with no prior cloud experience using automated scripts and clean structure

---

## Business Use Case

**Emmanuel Services** offers professional training, cloud consulting, and DevOps integration services. As demand grew globally, the company needed a scalable, fault-tolerant, and easy-to-manage platform to showcase its services and digital offerings. The infrastructure needed to meet these requirements:

- **Multi-cloud compatibility** to support clients in regulated and high-availability environments
- **Infrastructure as Code** to automate provisioning and ensure consistency
- **CI/CD pipelines** to shorten deployment cycles
- **Monitoring and visibility** to support SRE and FinOps practices
- **Declarative infrastructure** that can be managed from Kubernetes using Crossplane

---

## Repository Structure

```
emmanuel-services-infra-crossplane/
├── app/                      # Static website (HTML/CSS)
├── argo/                     # ArgoCD application manifests for GitOps
├── crossplane/               # Crossplane provider configuration per cloud
├── docker/                   # Dockerfile to build the application image
├── helm/                     # Helm chart to deploy app into Kubernetes
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
├── monitoring/               # Prometheus and Grafana manifests
├── scripts/                  # Shell scripts for automation
│   ├── push_to_ecr.sh
│   ├── push_to_acr.sh
│   ├── push_to_gcr.sh
│   ├── install_helm_chart.sh
│   ├── deploy_argocd.sh
│   ├── install_crossplane.sh
│   ├── port_forward_argocd.sh
│   └── port_forward_grafana.sh
├── terraform/                # Infrastructure modules per cloud
│   ├── aws/
│   │   ├── backend/
│   │   └── cluster/
│   ├── azure/
│   │   ├── backend/
│   │   └── cluster/
│   └── gcp/
│       ├── backend/
│       └── cluster/
└── README.md
```

---

## Cloud Deployment Workflow

1. **Clone Repository**
   ```
   git clone https://github.com/Here2ServeU/emmanuel-services-infra-crossplane.git
   cd emmanuel-services-infra-crossplane
   ```

2. **Build Docker Image**
   ```
   docker build -t emmanuel-services:v1 ./docker
   ```

3. **Push to Container Registry**
   - AWS:
     ```
     bash scripts/push_to_ecr.sh
     ```
   - Azure:
     ```
     bash scripts/push_to_acr.sh
     ```
   - GCP:
     ```
     bash scripts/push_to_gcr.sh
     ```

4. **Provision Kubernetes Infrastructure**
   - AWS EKS:
     ```
     cd terraform/aws/cluster
     terraform init
     terraform apply
     ```
   - Azure AKS:
     ```
     cd terraform/azure/cluster
     terraform init
     terraform apply
     ```
   - GCP GKE:
     ```
     cd terraform/gcp/cluster
     terraform init
     terraform apply
     ```

5. **Install Crossplane in Cluster**
   ```
   bash scripts/install_crossplane.sh
   ```

6. **Apply Provider Config**
   ```
   kubectl apply -f crossplane/aws.yaml      # or azure.yaml / gcp.yaml
   ```

7. **Install and Configure ArgoCD**
   ```
   bash scripts/deploy_argocd.sh
   kubectl apply -f argo/app.yaml
   bash scripts/port_forward_argocd.sh
   ```

8. **Deploy App via Helm**
   ```
   bash scripts/install_helm_chart.sh
   ```

9. **Enable Monitoring**
   ```
   kubectl apply -f monitoring/prometheus.yaml
   kubectl apply -f monitoring/grafana.yaml
   bash scripts/port_forward_grafana.sh
   ```

---

## CI/CD Pipeline (GitHub Actions)

Add this file to `.github/workflows/deploy.yml`:

```yaml
name: Build and Push

on:
  push:
    branches: [ main ]

jobs:
  docker-deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Log in to ECR
        uses: aws-actions/amazon-ecr-login@v1

      - name: Build and Push
        run: |
          docker build -t ${{ secrets.ECR_REGISTRY }}/emmanuel-services:v1 ./docker
          docker push ${{ secrets.ECR_REGISTRY }}/emmanuel-services:v1
```

---

## Script Responsibilities

Each script is designed to automate a real-world task typically handled by DevOps teams:

- `push_to_ecr.sh` / `push_to_acr.sh` / `push_to_gcr.sh`: Push container images to cloud registry
- `install_helm_chart.sh`: Package and deploy Helm chart to Kubernetes
- `deploy_argocd.sh`: Set up ArgoCD in the cluster for GitOps
- `install_crossplane.sh`: Install Crossplane for infrastructure orchestration
- `port_forward_argocd.sh`: Access ArgoCD UI on local machine
- `port_forward_grafana.sh`: Access Grafana dashboards locally

---

## Final Deliverable

This project delivers:
- End-to-end multi-cloud Kubernetes infrastructure
- Real-world automation scripts and Helm charts
- GitOps pipeline for consistency and rollback
- Monitoring stack ready for production
- Infrastructure designed for both professionals and beginners

This is a real DevOps case study, production-ready, and scalable for enterprise environments or training academies.

---

© 2025 Emmanuel Naweji. All rights reserved.
