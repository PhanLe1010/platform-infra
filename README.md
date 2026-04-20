# platform-infra

Infrastructure for the platform — one cluster per environment, managed
by Terraform. Each environment has its own state file.

## Structure

- `modules/` — reusable building blocks
  - `cluster` — creates a kind cluster
  - `argocd` — installs ArgoCD via Helm
  - `argocd-application` — registers an ArgoCD Application CR
- `environments/<env>/` — per-environment stacks with independent state

## Ownership

- Platform/SRE team owns everything in this repo
- Changes require review
- Production changes require extra approval

## Usage

For each environment, run terraform from that directory:

```bash
cd environments/staging
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

Then repeat for production:

```bash
cd ../production
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

## Accessing ArgoCD

After apply, each environment prints the port-forward command:

```bash
# Staging — port 8443
kubectl --context kind-platform-staging -n argocd port-forward svc/argocd-server 8443:443

# Production — port 8444
kubectl --context kind-platform-production -n argocd port-forward svc/argocd-server 8444:443
```

## Teardown

```bash
cd environments/staging && terraform destroy
cd environments/production && terraform destroy
```

## State management

Currently using local state for prep environment. In production:
- S3 backend with DynamoDB locking (AWS)
- GCS backend (GCP)
- Terraform Cloud remote state