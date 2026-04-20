variable "name" {
  description = "Name of the ArgoCD Application"
  type        = string
}

variable "argocd_namespace" {
  description = "Namespace where ArgoCD is installed"
  type        = string
}

variable "destination_namespace" {
  description = "Namespace in the cluster where the app will be deployed"
  type        = string
}

variable "gitops_repo_url" {
  description = "URL of the gitops repo"
  type        = string
}

variable "gitops_path" {
  description = "Path within the gitops repo to sync"
  type        = string
}

variable "gitops_target_revision" {
  description = "Branch or tag of the gitops repo"
  type        = string
  default     = "main"
}

variable "create_destination_namespace" {
  description = "Whether ArgoCD should create the destination namespace"
  type        = bool
  default     = true
}