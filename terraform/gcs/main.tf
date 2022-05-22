#Main Storage Bucket
resource "google_storage_bucket" "static-content" {
  provider      = google.gcs_impersonated
  name          = "${var.google_project}-static-content"
  location      = var.location
  uniform_bucket_level_access = true
  versioning {
    enabled = true
    }
  lifecycle_rule {
    condition {
      num_newer_versions = 3
    }
    action {
      type = "Delete"
    }
  }
}

data "google_iam_policy" "static-content-policy" {
  binding {
    role = "roles/storage.admin"
    members = ["serviceAccount:storage-admin@${var.google_project}.iam.gserviceaccount.com"]
  }
}

resource "google_storage_bucket_iam_policy" "static-content-member" {
  bucket = google_storage_bucket.static-content.name
  policy_data = data.google_iam_policy.static-content-policy.policy_data
}