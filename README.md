𝗻𝗼𝗱𝗲-𝗮𝗽𝗽-𝗰𝗶-𝗰𝗱
═══════════════════

𝗘𝗻𝗱-𝘁𝗼-𝗘𝗻𝗱 𝗗𝗲𝘃𝗦𝗲𝗰𝗢𝗽𝘀 𝗖𝗜/𝗖𝗗 𝗣𝗶𝗽𝗲𝗹𝗶𝗻𝗲 𝘂𝘀𝗶𝗻𝗴 𝗚𝗶𝘁𝗛𝘂𝗯 𝗔𝗰𝘁𝗶𝗼𝗻𝘀, 𝗗𝗼𝗰𝗸𝗲𝗿, 𝗔𝗪𝗦 𝗘𝗞𝗦, 𝗧𝗲𝗿𝗿𝗮𝗳𝗼𝗿𝗺, 𝗦𝗼𝗻𝗮𝗿𝗤𝘂𝗯𝗲, 𝗦𝗻𝘆𝗸, 𝗣𝗿𝗼𝗺𝗲𝘁𝗵𝗲𝘂𝘀, 𝗮𝗻𝗱 𝗚𝗿𝗮𝗳𝗮𝗻𝗮.

━━━━━━━━━━━━━━━━━━━━

𝗣𝗿𝗼𝗷𝗲𝗰𝘁 𝗢𝘃𝗲𝗿𝘃𝗶𝗲𝘄

This GitHub Actions workflow automates the build, security scanning, containerization, and deployment of a Node.js application.

The application is packaged as a Docker image, securely pushed to Amazon ECR, and deployed to a Kubernetes (EKS) cluster using predefined manifests.

Before deployment, the pipeline integrates Snyk security scanning to detect vulnerabilities in both application dependencies and the container image, ensuring that only secure artifacts are released.

The deployment phase also includes installation of Prometheus and Grafana monitoring using Helm to provide observability and operational visibility into the Kubernetes cluster.

━━━━━━━━━━━━━━━━━━━━

𝗣𝗿𝗼𝗷𝗲𝗰𝘁 𝗦𝘁𝗮𝘁𝘂𝘀

This project is complete and archived.
All cloud resources were destroyed after validation to prevent ongoing costs.

━━━━━━━━━━━━━━━━━━━━

𝗔𝗿𝗰𝗵𝗶𝘁𝗲𝗰𝘁𝘂𝗿𝗲

GitHub → GitHub Actions → SonarQube → Docker → Snyk → AWS ECR → Kubernetes (EKS) → Monitoring

━━━━━━━━━━━━━━━━━━━━

𝗦𝗲𝗰𝘂𝗿𝗶𝘁𝘆 & 𝗤𝘂𝗮𝗹𝗶𝘁𝘆 𝗚𝗮𝘁𝗲𝘀

• SonarQube Quality Gate enforcement within GitHub Actions
• Snyk container vulnerability blocking (HIGH and CRITICAL)
• Continuous container vulnerability monitoring with Snyk

Note: SonarQube Quality Gates are enforced in the GitHub Actions workflow. A screenshot was not captured during the final successful run, but the Quality Gate stage is implemented and blocks the workflow on failure.

━━━━━━━━━━━━━━━━━━━━

𝗞𝘂𝗯𝗲𝗿𝗻𝗲𝘁𝗲𝘀 𝗖𝗹𝘂𝗦𝘁𝗲𝗿 𝗠𝗼𝗻𝗶𝘁𝗼𝗿𝗶𝗻𝗴 (𝗚𝗿𝗮𝗳𝗮𝗻𝗮)

Grafana dashboards were successfully deployed using the kube-prometheus-stack Helm chart.

On the AWS Free Tier single-node EKS cluster, Prometheus could not be scheduled due to VPC CNI pod density limits, resulting in dashboards displaying “No data”.

This behavior is expected on resource-constrained clusters. In a production-grade setup, this would be resolved by scaling node capacity or optimizing monitoring component resource requests.

━━━━━━━━━━━━━━━━━━━━

⚙️ 𝗧𝗲𝗰𝗵 𝗦𝘁𝗮𝗰𝗸

• GitHub Actions
• Docker
• Terraform
• AWS (EKS, ECR, VPC)
• Kubernetes
• SonarQube
• Snyk
• Prometheus & Grafana

━━━━━━━━━━━━━━━━━━━━

𝗖𝗼𝘀𝘁 𝗠𝗮𝗻𝗮𝗴𝗲𝗺𝗲𝗻𝘁

All infrastructure was destroyed after testing using:

terraform destroy
Helm cleanup for monitoring components

This ensures AWS Free Tier cost safety.

━━━━━━━━━━━━━━━━━━━━

𝗥𝗲𝗹𝗲𝗮𝘀𝗲

v1.0-capstone
