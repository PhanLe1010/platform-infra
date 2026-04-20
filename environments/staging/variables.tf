variable "gitops_repo_url" {
  description = "URL of the gitops repo"
  type        = string
}

variable "gitops_target_revision" {
  description = "Branch or tag of the gitops repo"
  type        = string
  default     = "main"
}