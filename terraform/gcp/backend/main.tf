provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "tf_state" {
  name     = var.bucket_name
  location = var.region
  versioning {
    enabled = true
  }
}
