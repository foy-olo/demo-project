provider "google"{
  project = var.google_project
  region = "europe-west2"
  alias = "tokengenerator"
  }

#Service Account Access Token Generation
data "google_service_account_access_token" "gcs_sa" {
  provider = google.tokengenerator
  target_service_account = "storage-admin@${var.google_project}.iam.gserviceaccount.com"
  scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  lifetime = "300s"
  }

provider "google" {
  alias        = "gcs_impersonated"
  access_token = data.google_service_account_access_token.gcs_sa.access_token
}