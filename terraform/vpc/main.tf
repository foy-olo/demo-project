resource "google_project_service" "vpcaccess_api" {
  service  = "vpcaccess.googleapis.com"
  disable_on_destroy = false
}

#Main VPC
resource "google_compute_network" "vpc_network" {
  name                    = "main-vpc-network"
  auto_create_subnetworks = false
}

#Subnet With Private Google Access
resource "google_compute_subnetwork" "private" {
  name          = "private-subnetwork"
  ip_cidr_range = "10.0.0.0/8"
  region        = var.location
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true
  }

# VPC access connector
resource "google_vpc_access_connector" "connector" {
  name          = "vpcconn"
  region        = var.location
  ip_cidr_range = "10.8.0.0/8"
  network       = google_compute_network.vpc_network.name
  depends_on    = [google_project_service.vpcaccess_api]
}