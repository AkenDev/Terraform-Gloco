resource "google_container_cluster" "gke"{
    name = var.gke_cluster_name
    location = var.specific_zone

    network = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet.id

    remove_default_node_pool = true 
    initial_node_count = 1

    lifecycle {
        ignore_changes = [node_config]
    }
}

resource "google_container_node_pool" "nodes" {
  name       = var.node_pool_name
  location   = var.specific_zone
  cluster    = google_container_cluster.gke.id
  node_count = var.node_count

  node_config {
    preemptible  = false
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

