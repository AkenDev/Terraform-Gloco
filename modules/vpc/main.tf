resource "google_compute_network" "vpc" {
    # Uses variable defined in modules/vpc/variables.tf
    name                    = var.vpc_name
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
    # Uses variable defined in modules/vpc/variables.tf
    name          = var.subnet_name
    
    # Correctly references the network resource defined above
    network       = google_compute_network.vpc.id 
    
    # Uses variable defined in modules/vpc/variables.tf
    region        = var.region 
    
    # Hardcoded CIDR block - consider moving this to a variable later
    ip_cidr_range = "10.0.0.0/16" 
}