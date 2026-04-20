resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
    labels = {
      "managed-by" = "terraform"
    }
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.chart_version

  values = [
    yamlencode({
      server = {
        extraArgs = var.insecure ? ["--insecure"] : []
        service = {
          type = "ClusterIP"
        }
      }
      configs = {
        params = {
          "server.insecure" = var.insecure
        }
      }
    })
  ]

  wait    = true
  timeout = 600
}