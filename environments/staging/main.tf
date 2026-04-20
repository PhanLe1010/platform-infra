locals {
  environment = "staging"
}

module "cluster" {
  source       = "../../modules/cluster"
  cluster_name = "platform-${local.environment}"
  host_port    = 8080
}

module "argocd" {
  source        = "../../modules/argocd"
  namespace     = "argocd"
  chart_version = "5.51.6"
  insecure      = true

  depends_on = [module.cluster]
}

module "platform_app" {
  source = "../../modules/argocd-application"

  name                   = "platform-app"
  argocd_namespace       = module.argocd.namespace
  destination_namespace  = "platform-app"
  gitops_repo_url        = var.gitops_repo_url
  gitops_path            = "apps/platform-app/overlays/${local.environment}"
  gitops_target_revision = var.gitops_target_revision

  depends_on = [module.argocd]
}

output "argocd_port_forward_command" {
  value = "kubectl --context ${module.cluster.kubeconfig_context} -n ${module.argocd.namespace} port-forward svc/argocd-server 8443:443"
}

output "argocd_admin_password_command" {
  value = "kubectl --context ${module.cluster.kubeconfig_context} -n ${module.argocd.namespace} get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
}