resource "google_compute_global_address" "ip_address" {
  name          = var.name
  purpose       = var.purpose
  address_type  = var.address_type
  prefix_length = var.prefix_length
  network       = var.vpc_network
}

resource "google_service_networking_connection" "vpc_connection" {
  network                 = var.vpc_network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.ip_address.name]
}
