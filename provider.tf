terraform{
    required_version = ">= 1.3.0"

    backend "gcs"{
        bucket = "glocopreprod-terraform-state-bucket"
        prefix = "terraform/state"
    }
}

provider "google"{
    project= var.project_id
    region = var.regional_level
}