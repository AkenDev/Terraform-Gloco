## This block tells Terraform to fetch the details of your GCP project using the project_id you've already defined as a variable.
data "google_project" "project" {
  project_id = var.project_id
}