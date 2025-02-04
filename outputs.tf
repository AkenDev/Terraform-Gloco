# Output the GKE Cluster Name
output "gke_cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.gke.name
}

# Output the GKE Cluster Endpoint (API Server)
output "gke_endpoint" {
  description = "Endpoint to connect to the GKE cluster"
  value       = google_container_cluster.gke.endpoint
}

# Output the GKE Service Account Email
output "gke_service_account_email" {
  description = "Email of the GKE Service Account"
  value       = google_service_account.gke_sa.email
}

# Output the VPC Name
output "vpc_name" {
  description = "The name of the VPC created"
  value       = google_compute_network.vpc.name
}

# Output the Subnet Name
output "subnet_name" {
  description = "The name of the subnet created"
  value       = google_compute_subnetwork.subnet.name
}
