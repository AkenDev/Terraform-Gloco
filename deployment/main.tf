# 1. Calls the VPC Module
# Creates the VPC and Subnet, and outputs their IDs.
module "vpc" {
  source = "../modules/vpc"

  # Inputs for the VPC module (from root variables)
  # Uses root-level variables and passes them to the module inputs
  vpc_name    = var.vpc_name
  subnet_name = var.subnet_name
  region      = var.regional_level
}

# 2. Calls the GKE Cluster Module
# Creates the GKE cluster and node pool.
module "gke_cluster" {
  source = "../modules/gke-cluster"

  # Inputs for the GKE module (from root variables and VPC outputs)

  # A. Use Root Variables for Naming/Configuration:
  project_id       = var.project_id
  gke_cluster_name = var.gke_cluster_name
  node_pool_name   = var.node_pool_name
  machine_type     = var.machine_type
  node_count       = var.node_count
  location         = var.specific_zone # The GKE master is often placed in a specific zone

  # B. Use IAM Service Account Output (from poc-deployment/iam.tf)
  # The service account was defined in poc-deployment/iam.tf (same root module)
  node_service_account = google_service_account.gke_sa.email

  # C. Use VPC Module Outputs for Network Connection:
  # This is the crucial connection that links the two modules!
  vpc_network_id    = module.vpc.network_id
  vpc_subnetwork_id = module.vpc.subnetwork_id
}