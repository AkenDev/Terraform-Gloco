variable "project_id" {
  description = "The GCP project ID where the cluster is deployed."
  type        = string
}

variable "gke_cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "gloco-gke-cluster"
}

variable "node_pool_name" {
  description = "The name of the node pool"
  type        = string
  default     = "gloco-node-pool"
}

variable "machine_type" {
  description = "Machine type for node pool"
  type        = string
  default     = "e2-medium"
}

variable "node_count" {
  description = "Number of nodes in the pool"
  type        = number
  default     = 2
}

variable "location" {
  description = "The zone where the GKE cluster master is located."
  type        = string
}

# Variables to receive the network information from the VPC module (as discussed previously)
variable "vpc_network_id" {
  description = "The ID of the VPC network to attach the cluster to."
  type        = string
}

variable "vpc_subnetwork_id" {
  description = "The ID of the subnetwork for the GKE nodes."
  type        = string
}

variable "node_service_account" {
  description = "The service account email for the GKE nodes."
  type        = string
}