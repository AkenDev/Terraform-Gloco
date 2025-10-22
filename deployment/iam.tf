# poc-deployment/iam.tf

# 1. Assign Kubernetes Admin role to a specific user (User Access)
resource "google_project_iam_binding" "gke_admin" {
    project = var.project_id
    role    = "roles/container.admin"

    members = [
        "user:${var.gke_admin_user}"  
    ]
}

# 2. Define the GKE Cluster Service Account
resource "google_service_account" "gke_sa" {
    account_id   = "gke-service-account-poc" # Added '-poc' to ensure uniqueness
    display_name = "GKE Service Account POC"
}

# 3. Grant GKE Cluster Service Account the necessary roles (Roles for the GKE SA)
resource "google_project_iam_binding" "gke_sa_roles" {
    project = var.project_id
    role    = "roles/container.developer" 

    members = [
        "serviceAccount:${google_service_account.gke_sa.email}"
    ]
}

resource "google_project_iam_binding" "gke_compute_permissions" {
    project = var.project_id
    role    = "roles/compute.viewer" 

    members = [
        "serviceAccount:${google_service_account.gke_sa.email}"
    ]
}

resource "google_project_iam_binding" "gke_network_permissions" {
    project = var.project_id
    role    = "roles/compute.networkViewer" 

    members = [
        "serviceAccount:${google_service_account.gke_sa.email}"
    ]
}