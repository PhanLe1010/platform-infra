variable "cluster_name" {
  description = "Name of the kind cluster"
  type        = string
}

variable "host_port" {
  description = "Host port to map to the cluster's port 80"
  type        = number
  default     = 8080
}