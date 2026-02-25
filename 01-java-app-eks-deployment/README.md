# Java Application Deployment on Amazon EKS

---

## Project Description

This project demonstrates how to:

- Build a simple **Java (Maven) web application**
- Containerize it using Docker
- Push the image to a **private DockerHub repository**
- Provision an **Amazon EKS cluster using eksctl**
- Deploy the application to Kubernetes using `kubectl`
- Expose it using **NGINX Ingress Controller**
- Scale the application based on traffic

This is a **foundational DevOps project** focused on understanding Kubernetes deployment flow end-to-end without CI/CD automation.  
(Jenkins will be introduced in the next project.)

---

## Project Structure

```
.
├── Dockerfile
├── eksctl/
│   └── eks-config.yaml
├── kubernetes/
│   ├── deployment.yaml
│   └── service.yaml
├── pom.xml
├── src/
│   └── main/
│       ├── java/com/example/Application.java
│       └── resources/static/index.html
└── README.md
```

---

## ✅ Prerequisites

Ensure the following tools are installed and configured:

- **kubectl** – CLI tool to interact with Kubernetes clusters  
  https://kubernetes.io/docs/tasks/tools/

- **eksctl** – CLI tool to create and manage Amazon EKS clusters  
  https://eksctl.io/introduction/#installation

- **AWS CLI** – CLI tool to interact with AWS services (required for EKS)  
  https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

After installing AWS CLI, configure it:

```bash
aws configure
```

Verify installations:

```bash
kubectl version --client
eksctl version
aws --version
```

## 🐳 Containerization

## 🐳 Containerization

The application was packaged into a Docker container by building the app and image inside a multi-stage Dockerfile.

- Docker image is stored in a **private DockerHub repository**
- Kubernetes pulls image using Docker registry credentials (if configured)
- Multi-stage builds can be implemented for optimization (optional improvement)

---

## Amazon EKS Setup

The Kubernetes cluster was created using **eksctl**.

### Create Cluster

```bash
# Config file location
eksctl/eks-config.yaml

# Create cluster
eksctl create cluster -f eksctl/eks-config.yaml
```

Verify cluster:

```bash
kubectl get nodes
```

---

## Deployment

Deployment is done manually using `kubectl`. (Subsequent projects automate this using Jenkins CI/CD)

### Apply Resources

```bash
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
```

Verify deployment:

```bash
kubectl get pods
kubectl get svc
```

---

## Scaling

Scaling can be managed by adjusting the replica count(based on traffic) in:

```
kubernetes/deployment.yaml
```

Example:

```yaml
spec:
  replicas: 3
```

Apply changes:

```bash
kubectl apply -f kubernetes/deployment.yaml
```

Or scale dynamically:

```bash
kubectl scale deployment java-eks-app --replicas=5
```

This allows the application to handle increased traffic.

---

## 🌐 Application Access

The application is exposed using a Kubernetes Service of type **LoadBalancer**.

When deployed on Amazon EKS, this automatically provisions an AWS Elastic Load Balancer and assigns a public endpoint to access the application.

You can retrieve the external URL using:

```bash
kubectl get svc <service-name>
```

Once the LoadBalancer is provisioned, the application becomes accessible via the assigned external IP or DNS name.

> Subsequent projects will install an Ingress Controller for HTTP routing and evaluate ingress rules for more advanced traffic management.

---

### Flow of Traffic

```
Internet
   ↓
AWS Elastic Load Balancer (provisioned by Service type LoadBalancer)
   ↓
Kubernetes Service
   ↓
Pods
```
---

## 🔍 Verification Commands

```bash
kubectl get nodes
kubectl get pods
kubectl get svc
kubectl get ingress
kubectl describe pod <pod-name>
```

---

## 🧹 Cleanup

To delete the application:

```bash
kubectl delete -f kubernetes/deployment.yaml
kubectl delete -f kubernetes/service.yaml
```

To delete EKS cluster:

```bash
eksctl delete cluster -f eksctl/eks-config.yaml
```

---

## Key DevOps Concepts Demonstrated

- Docker image build and private DockerHub registry management
- Amazon EKS cluster provisioning using eksctl using config file
- Kubernetes Deployments and LoadBalancer Services
- Application scaling using replica management
- Container orchestration fundamentals on AWS
- End-to-end deployment workflow

---

## Next Step

In the next project:

- Introduce **Jenkins**
- Automate build & push process
- Implement full CI/CD pipeline
- Integrate with ECR instead of DockerHub
- Add automated deployment to EKS

---

This project builds a strong foundation for understanding Kubernetes deployments before introducing CI/CD automation.