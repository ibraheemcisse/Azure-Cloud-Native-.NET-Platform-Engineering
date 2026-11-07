# Azure Cloud-Native .NET Platform Engineering

A hands-on platform engineering project focused on building, deploying, securing, and automating a containerized .NET application on Microsoft Azure.

The workload is **PizzaStore API**, an ASP.NET Core application built with .NET 8, Entity Framework Core, and SQLite.

The project explores practical platform engineering concepts, including infrastructure as code, containerization, Kubernetes orchestration, persistent storage, cloud identity, and CI/CD automation.

## Architecture

```text
                  Developer
                      |
                      v
               GitHub Repository
                      |
                      v
                GitHub Actions
                      |
                Build & Push
                      |
                      v
             Azure Container Registry
                      |
                      v
          Azure Kubernetes Service
                      |
                      v
                PizzaStore API
                      |
                      v
              SQLite Persistent
                   Storage
```

Infrastructure is provisioned and managed using Terraform, with Azure Storage providing remote state management.

GitHub Actions provides the CI/CD workflow, using OpenID Connect (OIDC) federation and Azure managed identity for authentication.

## Technology Stack

| Area | Technology |
|---|---|
| Cloud Platform | Microsoft Azure |
| Application | .NET 8 / ASP.NET Core |
| API Architecture | REST API |
| ORM | Entity Framework Core |
| Database | SQLite |
| Containerization | Docker |
| Container Registry | Azure Container Registry |
| Orchestration | Azure Kubernetes Service |
| Infrastructure as Code | Terraform |
| Remote State | Azure Storage |
| CI/CD | GitHub Actions |
| Cloud Authentication | Managed Identity / OIDC |
| Container Runtime | containerd |
| Operating System | Linux |

## Infrastructure Overview

### Azure Resource Group

Application infrastructure is organized within the Azure resource group:

`rg-pizzastore-dev`

### Azure Container Registry

An Azure Container Registry instance stores the container images used by the Kubernetes workload.

- Registry: `ibraheempizzastoreacr`
- SKU: Basic
- Image: `pizzastore-api`

### Azure Kubernetes Service

The AKS cluster provides the Kubernetes orchestration environment for the PizzaStore API.

The infrastructure configuration includes:

- Managed Kubernetes cluster.
- Linux-based system node pool.
- Azure CNI Overlay networking.
- Azure RBAC integration.
- OpenID Connect and workload identity support.
- Standard Load Balancer.
- Automatic image cleaning.
- Kubernetes persistent storage.

### Terraform Remote State

Terraform state is stored remotely in Azure Storage.

The backend uses:

- Resource group: `rg-terraform-state`
- Storage account: `ibraheemtfstate`
- Container: `tfstate`
- State file: `pizzastore.terraform.tfstate`

This provides centralized state management rather than relying on local Terraform state files.

## CI/CD and Identity

GitHub Actions is configured to automate the PizzaStore application delivery workflow.

The workflow covers:

1. Checking out the repository.
2. Authenticating to Azure.
3. Building the Docker image.
4. Pushing the image to Azure Container Registry.
5. Configuring access to AKS.
6. Updating the Kubernetes deployment.
7. Verifying the deployment rollout.

### Authentication

The CI/CD identity uses Azure User Assigned Managed Identity and OpenID Connect federation.

This avoids storing long-lived Azure credentials in GitHub Actions.

The configuration includes:

- User-assigned managed identity.
- Federated identity credential.
- GitHub Actions OIDC authentication.
- Azure Container Registry push permissions.
- AKS cluster access permissions.
- Kubernetes namespace-level deployment permissions.

## Application Deployment

The PizzaStore API is containerized and deployed using Kubernetes manifests.

The deployment configuration includes:

- Kubernetes Deployment.
- Kubernetes ClusterIP Service.
- Persistent Volume Claim.
- SQLite database persistence.
- Startup, readiness, and liveness probes.
- CPU and memory resource requests and limits.
- Non-root container execution.
- Container privilege restrictions.

SQLite data is stored on a mounted persistent volume rather than relying on the container's writable filesystem.

## Security Considerations

Security practices incorporated into the project include:

- Non-root container execution.
- Restricted container privileges.
- Kubernetes resource requests and limits.
- Azure role-based access control.
- Managed identity authentication.
- OIDC federation for CI/CD.
- Separation of Terraform infrastructure state from application resources.
- No reliance on long-lived Azure credentials in the deployment workflow.

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       └── deploy.yml
│
├── docs/
│   ├── architecture/
│   ├── decisions/
│   ├── operations/
│   └── resilience/
│
├── infrastructure/
│   └── terraform/
│       ├── aks.tf
│       ├── github-actions.tf
│       └── ...
│
├── kubernetes/
│   ├── pizzastore-deployment.yaml
│   └── pizzastore-service.yaml
│
├── scripts/
│   └── build-and-push-pizzastore.sh
│
└── src/
    └── PizzaStore.Api/
        └── Dockerfile
```

## Implementation Summary

The project covers the following engineering work:

- [x] Developed the ASP.NET Core PizzaStore API using .NET 8.
- [x] Containerized the application using a multi-stage Docker build.
- [x] Configured non-root container execution.
- [x] Implemented SQLite persistence.
- [x] Built and pushed application images to Azure Container Registry.
- [x] Established Terraform infrastructure configuration.
- [x] Configured Azure Storage remote state backend.
- [x] Provisioned Azure Kubernetes Service infrastructure.
- [x] Deployed and tested the application on AKS.
- [x] Configured Kubernetes persistent storage.
- [x] Created Kubernetes deployment and service manifests.
- [x] Configured GitHub Actions CI/CD workflow.
- [x] Established Azure managed identity for GitHub Actions.
- [x] Configured OIDC federation between GitHub Actions and Azure.
- [x] Configured Azure permissions for the deployment identity.

## Project Philosophy

This project prioritizes practical engineering over unnecessary application complexity.

Rather than spending time building a large application, the focus is on the platform surrounding the workload:

- Infrastructure automation.
- Containerization.
- Kubernetes orchestration.
- Cloud identity and access management.
- Deployment automation.
- Persistent storage.
- Security and operational practices.

The objective is to understand how application workloads are provisioned, deployed, and managed in a cloud-native environment using infrastructure and automation tools.

---

**Repository:** [azure-cloud-native-dotnet-microservices](https://github.com/ibraheemcisse/azure-cloud-native-dotnet-microservices)
