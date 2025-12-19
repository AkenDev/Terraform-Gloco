# poc-deployment/variables.tf

# 1. Core GCP & IAM
variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "regional_level" {
  description = "The region for provider and networking resources"
  type        = string
  default     = "us-central1"
}

variable "specific_zone" {
  description = "The zone for GKE cluster"
  type        = string
  default     = "us-central1-a"
}

variable "gke_admin_user" {
  description = "The email address of the user to grant container.admin role on the project."
  type        = string
}

# 2. Networking Variables (Passed to VPC module)
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "gloco-vpc"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "gloco-subnet"
}

# 3. GKE Cluster Variables (Passed to GKE module)
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