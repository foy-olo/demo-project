resource "google_cloud_run_service" "hello-world" {
  name     = "hello-world"
  location = var.location
  project  = var.google_project
  autogenerate_revision_name = true

  template {
    spec {
      containers {
        image = data.external.image_digest.result.image
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"      = "1000"
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.instance.connection_name
        "run.googleapis.com/client-name"        = "terraform"
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

data "external" "image_digest" {
  program = ["bash", "scripts/get_latest_tag.sh", var.google_project, local.service_name]
}

resource "google_sql_database_instance" "instance" {
  name             = "cloudrun-sql"
  region           = var.location
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "true"
}