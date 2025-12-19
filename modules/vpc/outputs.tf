output "network_id" {
  description = "The ID of the created VPC network."
  value       = google_compute_network.vpc.id
}

output "subnetwork_id" {
  description = "The ID of the created subnetwork."
  value       = google_compute_subnetwork.subnet.id
}