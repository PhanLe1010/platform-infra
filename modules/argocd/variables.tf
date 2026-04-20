variable "namespace" {
  description = "Namespace for ArgoCD"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
  description = "ArgoCD Helm chart version"
  type        = string
  default     = "5.51.6"
}

variable "insecure" {
  description = "Run ArgoCD server in insecure mode (TLS off). True for local dev."
  type        = bool
  default     = false
}