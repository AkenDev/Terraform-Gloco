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

output "gke_node_count" {
  description = "The gcloud command to get the node count of the cluster"
  value       = var.node_count
}

# Output 1: Email of the GHA Service Account (used for IAM bindings and WIF)
output "gha_service_account_email" {
  description = "The email address of the GitHub Actions Deployer Service Account."
  value       = google_service_account.gha_sa.email
}

# Output 2: GHA Service Account ID (used in some IAM or auditing configurations)
output "gha_service_account_id" {
  description = "The unique ID of the GitHub Actions Deployer Service Account."
  value       = google_service_account.gha_sa.unique_id
}

# Output 3: Full Project Number (CRITICAL for WIF setup)
# We need the PROJECT NUMBER, not the ID, for the WIF trust relationship member.
output "project_number" {
  description = "The numeric project number for IAM operations."
  value       = data.google_project.project.number
}