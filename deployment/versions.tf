terraform {
    required_version = ">= 1.3.0"

    # Remote Backend Configuration (GCS)
    backend "gcs" {
        bucket = "glocopreprod1-terraform-state-bucket" # MUST be created before terraform init
        prefix = "poc-deployment/state"                 # Updated prefix for POC isolation
    }

    # Required Providers
    required_providers {
        google = {
            source  = "hashicorp/google"
            version = "~> 5.0" # Always good practice to pin the version range
        }
    }
}

# Provider Configuration
provider "google" {
    project = var.project_id
    region  = var.regional_level
}