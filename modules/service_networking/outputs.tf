output "ip_address" {
  description = "the reserved ip address value"
  value = google_compute_global_address.ip_address.name
}

output "peering" {
  description = "peering connection name"
  value = google_service_networking_connection.vpc_connection.peering
}