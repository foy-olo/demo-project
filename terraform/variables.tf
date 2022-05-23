variable "google_project" {
  description = "The Project ID"
  type = string
  default = "app-demo-project-350019"
  }

variable "location" {
  description = "The region of the VPC resource"
  type = string
  default = "europe-west2"
  }

locals {
  service_folder = "service"
  service_name   = "hello-world"
  }