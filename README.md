# Azure Cloud-Native .NET Platform Engineering

A hands-on platform engineering project focused on deploying, securing, automating, and operating a containerized .NET application on Microsoft Azure.

The workload is **PizzaStore API**, an ASP.NET Core application built with .NET 8, Entity Framework Core, and SQLite.

The project demonstrates the engineering practices involved in taking an application from a container image to a production-oriented Kubernetes deployment.

## Architecture

```text
Developer
    |
    v
GitHub Repository
    |
    v
Docker Image
    |
    v
Azure Container Registry
    |
    v
Azure Kubernetes Service
    |
    v
PizzaStore API
```

Infrastructure will be provisioned and managed using Terraform, with GitHub Actions providing CI/CD automation.

## Technology Stack

| Area | Technology |
|---|---|
| Cloud | Microsoft Azure |
| Application | .NET 8 / ASP.NET Core |
| Database | SQLite |
| Containers | Docker |
| Container Registry | Azure Container Registry |
| Orchestration | Azure Kubernetes Service |
| Infrastructure as Code | Terraform |
| CI/CD | GitHub Actions |
| Observability | OpenTelemetry |

## Engineering Objectives

- Provision Azure infrastructure using Terraform.
- Deploy and operate workloads on AKS.
- Automate image builds and deployments through GitHub Actions.
- Implement secure workload identity and secrets management.
- Configure application and infrastructure observability.
- Investigate Kubernetes networking and service reliability.
- Test failure scenarios and document resilience behaviour.
- Document operational procedures and architectural decisions.

## Implementation Status

### Completed

- [x] ASP.NET Core PizzaStore API.
- [x] Docker containerization with a multi-stage build.
- [x] Non-root container execution.
- [x] SQLite persistence using a mounted volume.
- [x] Azure Container Registry provisioned.
- [x] PizzaStore API image pushed to ACR (`v1`).

### In Progress

- [ ] Terraform infrastructure provisioning.
- [ ] Azure Kubernetes Service deployment.
- [ ] Kubernetes manifests and application configuration.
- [ ] GitHub Actions CI/CD pipeline.
- [ ] Managed identity and secrets management.
- [ ] OpenTelemetry observability.
- [ ] Resilience and failure experiments.

## Repository Structure

```text
.
├── .github/
│   └── workflows/
├── docs/
│   ├── architecture/
│   ├── decisions/
│   ├── operations/
│   └── resilience/
├── infrastructure/
│   └── terraform/
├── kubernetes/
├── scripts/
└── src/
    └── PizzaStore.Api/
```

## Project Philosophy

This project prioritizes practical engineering over unnecessary application complexity.

The focus is on infrastructure automation, deployment reliability, security, observability, troubleshooting, and operational excellence.

Implementation decisions and lessons learned will be documented throughout the project.
