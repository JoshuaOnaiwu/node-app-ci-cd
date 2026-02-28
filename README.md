node-app-ci-cd

End-to-End DevSecOps CI/CD Pipeline using GitHub Actions, Docker, AWS EKS, Kubernetes, Snyk, Prometheus, and Grafana.

📌 Project Overview

This project implements a full DevSecOps CI/CD pipeline for a Node.js application deployed to AWS EKS.

The GitHub Actions pipeline automates the build, security validation, containerization, and deployment workflow.

The application is packaged as a Docker image, securely pushed to Amazon ECR, and deployed to a Kubernetes (EKS) cluster using predefined manifests.

Before deployment, the pipeline incorporates Snyk dependency scanning to identify vulnerabilities in the application dependencies, ensuring that only secure artifacts are released.

The deployment process includes automated rollout validation and horizontal pod autoscaling. Monitoring is enabled through Prometheus and Grafana installed via Helm to provide observability into cluster health and application performance.

📍 Project Status

This project is complete.

All components were successfully:

• Built
• Secured
• Deployed
• Scaled
• Monitored
• Debugged (including CrashLoopBackOff and rollout timeout scenarios)

The infrastructure remains active for demonstration purposes.
In a production environment, infrastructure teardown would be handled via Infrastructure-as-Code to prevent ongoing costs.

🧱 Architecture

GitHub → GitHub Actions → Snyk → Docker → AWS ECR → Kubernetes (EKS) → HPA → Prometheus → Grafana

This reflects a production-style delivery chain:

Application → Container → Registry → Cluster → Autoscaling → Observability → Security

🔐 Security & Quality Controls

Snyk dependency scanning is integrated directly into the CI pipeline.

Security enforcement includes:

• Blocking HIGH severity vulnerabilities
• Preventing insecure builds from reaching ECR
• Automated validation before deployment

Container-level scanning was evaluated during implementation, with plan limitations documented.

Health probes and rollout validation ensure only stable workloads are promoted.

📊 Kubernetes Cluster Monitoring (Grafana)

Grafana dashboards were successfully deployed using the kube-prometheus-stack Helm chart.

Monitoring components include:

• Prometheus
• Grafana
• kube-state-metrics
• node-exporter

Dashboards provide visibility into:

• Pod CPU usage
• Memory utilization
• Node health
• Horizontal Pod Autoscaler behavior

Monitoring was validated against live cluster metrics.

⚙️ CI/CD Pipeline Flow

Continuous Integration:

Checkout repository

Install dependencies

Run tests

Execute Snyk dependency scan

Build Docker image

Tag image using commit SHA

Continuous Delivery:

Authenticate to AWS

Push image to Amazon ECR

Update Kubernetes deployment image

Apply manifests

Wait for rollout completion

Rollout status is programmatically verified to prevent incomplete deployments.

🐳 Docker Strategy

• Lightweight node:24-alpine base image
• Production-only dependencies (npm install --omit=dev)
• Optimized build layering for cache efficiency
• Image versioned using Git commit SHA
• Immutable container deployment

CrashLoopBackOff debugging revealed entrypoint path misalignment, which was resolved by aligning Docker CMD with the application start script.

📂 Repository Structure
.
├── app/                    # Node.js application
├── infra/                  # Infrastructure-related configs (IAM, cluster files)
├── k8s/                    # Kubernetes manifests
│   ├── deployment.yaml
│   ├── service.yaml
│   └── hpa.yaml
├── .github/workflows/      # GitHub Actions CI/CD pipeline
├── Dockerfile              # Production container definition
└── README.md
🧪 Deployment Validation

During implementation, the following real-world issues were encountered and resolved:

• Docker build context misalignment
• Incorrect container entrypoint (MODULE_NOT_FOUND)
• CrashLoopBackOff debugging
• Kubernetes rollout timeout
• Invalid manifest validation errors
• IAM JSON mistakenly applied as Kubernetes resources

These were resolved through structured debugging using:

kubectl describe pod
kubectl logs
kubectl get events
kubectl rollout status
🧹 Cost Management

In a production or cost-sensitive environment:

• EKS clusters would be destroyed using Infrastructure-as-Code
• Helm monitoring components would be removed
• ECR lifecycle policies would manage image retention

This ensures cloud cost control and operational hygiene.

🏷️ Release

v1.0.0 – Production-Style DevSecOps Pipeline
