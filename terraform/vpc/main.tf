#Main VPC
resource "google_compute_network" "vpc_network" {
  name                    = "main-vpc-network"
  auto_create_subnetworks = false
}

#Public Subnet
resource "google_compute_subnetwork" "public" {
  name          = "public-subnetwork"
  ip_cidr_range = "10.2.0.0/24"
  region        = var.location
  network       = google_compute_network.main.id
  }

#Private Subnet
resource "google_compute_subnetwork" "private" {
  name          = "private-subnetwork"
  ip_cidr_range = "10.2.1.0/24"
  region        = var.location
  network       = google_compute_network.main.id
  }