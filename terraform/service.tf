resource "google_cloud_run_service" "hello-world" {
  name     = "hello-world"
  location = ${var.location}
  project  = ${var.google_project}
  autogenerate_revision_name = true

  template {
    spec {
      containers {
        image = data.external.image_digest.result.image
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.hello-world.location
  project     = google_cloud_run_service.hello-world.project
  service     = google_cloud_run_service.hello-world.name

  policy_data = data.google_iam_policy.noauth.policy_data
}