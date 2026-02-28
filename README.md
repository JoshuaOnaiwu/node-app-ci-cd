node-app-ci-cd

End-to-End DevSecOps CI/CD Pipeline using GitHub Actions, Docker, AWS EKS, Kubernetes, Snyk, Prometheus, and Grafana.

📌 Project Overview

This project implements a full DevSecOps CI/CD pipeline for a Node.js application deployed to AWS EKS.

The pipeline automates:

Application build and testing

Dependency vulnerability scanning with Snyk

Docker image creation

Secure image push to Amazon ECR

Kubernetes deployment update

Rollout validation

Horizontal Pod Autoscaling

Cluster monitoring with Prometheus & Grafana

Each commit to the main branch triggers a complete automated build and deployment cycle.

Only validated and scanned artifacts are deployed to the Kubernetes cluster.

📍 Project Status

This project is complete.

All components were successfully:

Built

Secured

Deployed

Scaled

Monitored

Debugged (including CrashLoopBackOff scenarios)

The infrastructure remains active for demonstration purposes.
In a real-world scenario, Terraform or IaC teardown would be used to destroy cloud resources and prevent ongoing cost.

🧱 Architecture

GitHub → GitHub Actions → Snyk → Docker → AWS ECR → Kubernetes (EKS) → HPA → Prometheus → Grafana

This reflects a production-style delivery chain:

Application → Container → Registry → Cluster → Autoscaling → Observability → Security

🔐 Security & Quality Controls

Snyk dependency scanning is integrated directly into the CI pipeline.

The pipeline:

Blocks on HIGH severity vulnerabilities

Ensures secure dependency versions

Prevents insecure artifacts from reaching ECR

Container-level scanning was evaluated, with plan limitations noted during implementation.

Resource constraints and health probes were validated during deployment testing.

⚙️ CI/CD Pipeline Flow
Continuous Integration

Checkout repository

Install dependencies

Run application tests

Execute Snyk security scan

Build Docker image

Tag image with commit SHA

Continuous Delivery

Authenticate to AWS

Push image to ECR

Update Kubernetes deployment image

Apply manifests

Wait for rollout completion

Rollout validation ensures pods are healthy before marking the deployment successful.

☸ Kubernetes Configuration
Deployment

Rolling updates enabled

Resource requests and limits configured

Liveness probe

Readiness probe

CrashLoopBackOff debugging performed

Service

Type: LoadBalancer

Exposes application on port 3000

Horizontal Pod Autoscaler (HPA)

CPU-based scaling

Minimum: 2 replicas

Maximum: 5 replicas

📊 Monitoring & Observability

Monitoring stack deployed using Helm:

Prometheus

Grafana

kube-state-metrics

node-exporter

Grafana dashboards provide:

Pod CPU utilization

Memory usage

Node health

Autoscaling visibility

Monitoring was validated against live cluster metrics.

🐳 Docker Strategy

Lightweight node:24-alpine base image

Production-only dependencies installed

Optimized build layering

Image versioned using Git commit SHA

Immutable container deployment

CrashLoopBackOff debugging revealed entrypoint path issues, which were resolved by aligning Docker CMD with application start script.

📂 Repository Structure
.
├── app/                    # Node.js application
├── infra/                  # Infrastructure files (IAM, cluster-related configs)
├── k8s/                    # Kubernetes manifests
│   ├── deployment.yaml
│   ├── service.yaml
│   └── hpa.yaml
├── .github/workflows/      # GitHub Actions CI/CD pipeline
├── Dockerfile              # Production container image definition
└── README.md
🧪 Deployment Validation

During implementation, the following real-world issues were encountered and resolved:

Docker build context misalignment

Incorrect container entrypoint (MODULE_NOT_FOUND)

CrashLoopBackOff debugging

Kubernetes rollout timeout

Invalid manifest validation errors

IAM JSON mistakenly applied as Kubernetes resources

These were resolved through structured debugging and inspection using:

kubectl describe pod
kubectl logs
kubectl get events
kubectl rollout status
🧹 Cost & Lifecycle Management

In a production or cost-sensitive environment:

EKS cluster would be destroyed using IaC

Helm monitoring stack would be removed

ECR images would be lifecycle-managed

Infrastructure cleanup ensures AWS cost safety.

🏷️ Release

v1.0.0 – Production-Style DevSecOps Pipeline
