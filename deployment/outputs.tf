# 1. Output from the root-level IAM resource (for reference)
output "gke_service_account_email" {
    description = "The email of the GKE cluster node service account."
    value       = google_service_account.gke_sa.email
}

# 2. Outputs from the GKE module
output "gke_cluster_endpoint" {
    description = "The public endpoint of the GKE cluster master."
    value       = module.gke_cluster.cluster_endpoint
}

output "gke_kubeconfig_command" {
    description = "The gcloud command to configure kubectl access to the cluster."
    value       = module.gke_cluster.kubeconfig_command
}