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