resource "google_compute_network" "vpc"{
    name = var.vpc_name
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet"{
    name = var.subnet_name
    network = google_compute_network.vpc.id
    region = var.regional_level
    ip_cidr_range = "10.0.0.0/16"
}