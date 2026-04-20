resource "kubernetes_namespace" "destination" {
  count = var.create_destination_namespace ? 1 : 0

  metadata {
    name = var.destination_namespace
    labels = {
      "managed-by" = "terraform"
    }
  }
}

resource "kubernetes_manifest" "application" {
  depends_on = [kubernetes_namespace.destination]

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = var.name
      namespace = var.argocd_namespace
      labels = {
        "managed-by" = "terraform"
      }
    }

    spec = {
      project = "default"

      source = {
        repoURL        = var.gitops_repo_url
        targetRevision = var.gitops_target_revision
        path           = var.gitops_path
      }

      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = var.destination_namespace
      }

      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = [
          "CreateNamespace=false"
        ]
      }
    }
  }
}