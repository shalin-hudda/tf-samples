output "region_id" {
  description = "the region id"
  value = google_container_cluster.default.location
}

output "cluster_id" {
  description = "the cluster id"
  value = google_container_cluster.default.name
}