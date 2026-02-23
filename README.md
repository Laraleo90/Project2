## Microservices Voting App: Project 2 (Kubernetes Edition)

Cloud-Native Orchestration & Automated GitOps Pipeline
This project focuses on the deployment of a multi-tier application using Kubernetes (AWS EKS). It features a fully automated CI/CD pipeline that handles container builds and rolling updates to the cluster.

📂 Project Architecture & File Structure
The project is organized into two main areas: the application source code and the Kubernetes infrastructure manifests.

ironhack-project-1/: Contains the source code for the microservices:

vote/: Python/Flask frontend for user input.

result/: Node.js dashboard to display live results.

worker/: .NET service that processes data from Redis to Postgres.

k8s/: The "Infrastructure as Code" manifests for Kubernetes:

Deployments & Services: Config for vote, result, worker, redis, and postgres.

Storage: storage-class.yaml and postgres-pvc.yaml for persistent EBS volumes.

Ingress: ingress.yaml for host-based routing (e.g., vote.lara.local).

Cluster: cluster.yaml used for EKS cluster specifications.

🤖 CI/CD Pipeline (cicd.yml)
The deployment is managed by a GitHub Actions workflow designed to be "smart" and efficient.

1. Smart Build Logic
The pipeline detects which directory has been modified using git diff. It only rebuilds and pushes the Docker image for the specific service that was changed (e.g., if you only edit the vote app, the worker image is not rebuilt).

2. Versioning & Registry
Images: Pushed to Docker Hub.

Tagging: Each build is tagged with both :latest and the specific ${{ github.sha }} for precise version tracking and easy rollbacks.

3. Automated Deployment
Once the new image is pushed, the runner:

Authenticates with AWS EKS via IAM secrets.

Updates the kubeconfig.

Executes kubectl apply -f k8s/ to trigger a rolling update in the cluster.

🛠️ Local Setup & Access
1. Pre-requisites
A running EKS cluster (created via eksctl create cluster -f k8s/cluster.yaml).

Kubernetes Secrets configured for database credentials:

Bash
kubectl create secret generic db-credentials --from-literal=username=postgres --from-literal=password=postgres
2. Local DNS Configuration
Since the Ingress uses host-based routing, you must map your LoadBalancer IP to the local hostnames in your /etc/hosts file:

Plaintext
vote.lara.local
result.lara.local

📊 Deployment Summary
Orchestrator: AWS EKS (Elastic Kubernetes Service)

Ingress Controller: NGINX

Storage: Amazon EBS (via PersistentVolumeClaims)

CI/CD: GitHub Actions (Path-based triggers)