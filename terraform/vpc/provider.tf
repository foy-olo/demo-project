provider "google"{
  project = var.google_project
  region = "europe-west2"
  alias = "tokengenerator"
  }

#Service Account Access Token Generation
data "google_service_account_access_token" "vpc_sa" {
  provider = google.tokengenerator
  target_service_account = "vpc-admin@${var.google_project}.iam.gserviceaccount.com"
  scopes = ["userinfo-email", "cloud-platform"]
  lifetime = "300s"
  }

provider "google" {
  alias        = "vpc_impersonated"
  access_token = data.google_service_account_access_token.vpc_sa.access_token
}

data "google_client_openid_userinfo" "me" {
  provider = google.vpc_impersonated
}

output "target-email" {
  value = data.google_client_openid_userinfo.me.email
}