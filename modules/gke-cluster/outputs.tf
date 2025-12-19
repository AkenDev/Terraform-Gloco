output "cluster_name" {
  description = "The name of the GKE cluster."
  value       = google_container_cluster.gke.name
}

output "cluster_endpoint" {
  description = "The public endpoint of the GKE cluster master."
  value       = google_container_cluster.gke.endpoint
}

output "kubeconfig_command" {
  description = "The gcloud command to configure kubectl access to the cluster."
  value       = "gcloud container clusters get-credentials ${google_container_cluster.gke.name} --zone ${var.location} --project ${var.project_id}"
  sensitive   = false # Note: We need the project_id here, which is passed from the root
}

output "node_pool_id" {
  description = "The ID of the main node pool."
  value       = google_container_node_pool.nodes.id
}