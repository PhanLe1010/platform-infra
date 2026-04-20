output "cluster_name" {
  value = kind_cluster.this.name
}

output "kubeconfig_context" {
  value = "kind-${kind_cluster.this.name}"
}

output "endpoint" {
  value = kind_cluster.this.endpoint
}