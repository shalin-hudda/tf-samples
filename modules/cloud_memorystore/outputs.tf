output "id" {
  description = "The memorystore instance ID."
  value       = google_redis_instance.memorystore_instance.id
}

output "host" {
  description = "The IP address of the instance."
  value       = google_redis_instance.memorystore_instance.host
}

output "port" {
  description = "The port number of the exposed Redis endpoint."
  value       = google_redis_instance.memorystore_instance.port
}

output "region" {
  description = "The region the instance lives in."
  value       = google_redis_instance.memorystore_instance.region
}

output "current_location_id" {
  description = "The current zone where the Redis endpoint is placed."
  value       = google_redis_instance.memorystore_instance.current_location_id
}

output "persistence_iam_identity" {
  description = "Cloud IAM identity used by import/export operations. Format is 'serviceAccount:'. May change over time"
  value       = google_redis_instance.memorystore_instance.persistence_iam_identity
}

output "auth_string" {
  description = "AUTH String set on the instance. This field will only be populated if auth_enabled is true."
  value       = google_redis_instance.memorystore_instance.auth_string
}