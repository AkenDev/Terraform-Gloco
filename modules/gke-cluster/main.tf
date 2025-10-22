resource "google_container_cluster" "gke" {
    # 1. Use the GKE module's internal variable for the cluster name
    name     = var.gke_cluster_name
    
    # 2. Use the GKE module's internal variable for location
    location = var.location 

    # 3. Replace cross-module references with GKE module input variables
    network    = var.vpc_network_id
    subnetwork = var.vpc_subnetwork_id

    remove_default_node_pool = true 
    initial_node_count       = 1

    lifecycle {
        ignore_changes = [node_config]
    }
}

resource "google_container_node_pool" "nodes" {
    # 4. Use GKE module's internal variables for node pool configuration
    name       = var.node_pool_name
    location   = var.location
    
    # This remains an internal reference, which is correct
    cluster    = google_container_cluster.gke.id 
    node_count = var.node_count

    node_config {
        preemptible  = false
        machine_type = var.machine_type
        oauth_scopes = [
            "https://www.googleapis.com/auth/cloud-platform"
        ]

        service_account = var.node_service_account
        
    }
}