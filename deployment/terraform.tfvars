# 1. Root Deployment Variables (from deployment/variables.tf)
project_id     = "glocoproject-poc" # MUST be set to your GCP Project ID
regional_level = "us-central1"
specific_zone  = "us-central1-a"
gke_admin_user = "dw0676102@gmail.com"


# 2. VPC Module Variables (passed to the 'vpc' module call)
# These override the defaults, if needed, but are included here for clarity
vpc_name    = "gloco-vpc"
subnet_name = "gloco-subnet"

# 3. GKE Cluster Module Variables (passed to the 'gke-cluster' module call)
# These override the defaults, if needed, but are included here for clarity
gke_cluster_name = "gloco-gke-cluster"
node_pool_name   = "gloco-node-pool"
machine_type     = "e2-medium"
node_count       = 2