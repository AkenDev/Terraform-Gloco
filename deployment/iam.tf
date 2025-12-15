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

resource "google_project_iam_binding" "gke_network_permissions" {
    project = var.project_id
    role    = "roles/rtifactregistry.reader" 

    members = [
        "serviceAccount:${google_service_account.gke_sa.email}"
    ]
}

# 4. Define the Service Account for GitHub Actions (GHA) Deployments
resource "google_service_account" "gha_sa" {
    account_id   = "gha-deployer-sa-poc"
    display_name = "GitHub Actions Deployer SA POC"
    project      = var.project_id
}

# 5. Grant GHA SA the necessary roles for CI/CD
# Permission to push (write) to Artifact Registry
resource "google_project_iam_binding" "gha_artifact_writer" {
    project = var.project_id
    role    = "roles/artifactregistry.writer"

    members = [
        "serviceAccount:${google_service_account.gha_sa.email}"
    ]
}

# Permission to deploy (access) the GKE cluster
resource "google_project_iam_binding" "gha_gke_developer" {
    project = var.project_id
    role    = "roles/container.developer"

    members = [
        "serviceAccount:${google_service_account.gha_sa.email}"
    ]
}