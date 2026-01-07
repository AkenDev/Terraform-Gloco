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
#resource "google_project_iam_binding" "gke_sa_roles" {
#    project = var.project_id
#    role    = "roles/container.developer" 
#
#    members = [
#        "serviceAccount:${google_service_account.gke_sa.email}"
#    ]
#}

resource "google_project_iam_binding" "gke_compute_permissions" {
  project = var.project_id
  role    = "roles/compute.viewer"

  members = [
    "serviceAccount:${google_service_account.gke_sa.email}"
  ]
}

resource "google_project_iam_binding" "gke_network_viewer" {
  project = var.project_id
  role    = "roles/compute.networkViewer"

  members = [
    "serviceAccount:${google_service_account.gke_sa.email}"
  ]
}

resource "google_project_iam_binding" "gke_artifact_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"

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
resource "google_project_iam_binding" "container_developer" {
  project = var.project_id
  role    = "roles/container.developer"

  members = [
    "serviceAccount:${google_service_account.gha_sa.email}",
    "serviceAccount:${google_service_account.gke_sa.email}",
  ]
}

# Define the main container for WIF identities
resource "google_iam_workload_identity_pool" "gloco_pool" {
  project                   = var.project_id
  workload_identity_pool_id = "gloco-pool"
  display_name              = "Gloco GHA WIF Pool"
  description               = "WIF Pool for GitHub Actions Deployment"
}

# Define the trusted identity provider (GitHub)
resource "google_iam_workload_identity_pool_provider" "github_provider" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.gloco_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "GitHub OIDC Provider"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }

  oidc {
    issuer_uri        = "https://token.actions.githubusercontent.com"
    ## allowed_audiences = ["AkenDev"]
  }

  attribute_condition = "assertion.repository == 'AkenDev/Gloco'"
}

# Bind the GHA Service Account to the GitHub Provider
resource "google_service_account_iam_member" "gha_wif_binding" {
  service_account_id = google_service_account.gha_sa.name
  role               = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.gloco_pool.workload_identity_pool_id}/attribute.repository/AkenDev/Gloco"
}