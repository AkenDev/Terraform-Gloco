# Assign Kubernetes Admin role to a specific user
resource "google_project_iam_binding" "gke_admin" {
  project = var.project_id
  role    = "roles/container.admin"

  members = [
    "user:gloco.bermudez@gmail.com"
  ]
}

# Grant GKE Cluster Service Account the necessary roles
resource "google_service_account" "gke_sa" {
  account_id   = "gke-service-account"
  display_name = "GKE Service Account"
}

resource "google_project_iam_binding" "gke_sa_roles" {
  project = var.project_id
  role    = "roles/container.developer" # GKE Developer Permissions

  members = [
    "serviceAccount:${google_service_account.gke_sa.email}"
  ]
}

resource "google_project_iam_binding" "gke_compute_permissions" {
  project = var.project_id
  role    = "roles/compute.viewer" # View Compute Engine Resources

  members = [
    "serviceAccount:${google_service_account.gke_sa.email}"
  ]
}

resource "google_project_iam_binding" "gke_network_permissions" {
  project = var.project_id
  role    = "roles/compute.networkViewer" # View Networking Resources

  members = [
    "serviceAccount:${google_service_account.gke_sa.email}"
  ]
}