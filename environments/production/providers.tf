provider "kind" {}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = module.cluster.kubeconfig_context
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = module.cluster.kubeconfig_context
  }
}