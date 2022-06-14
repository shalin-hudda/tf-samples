resource "google_redis_instance" "memorystore_instance" {
  name                    = var.db_instance
  tier                    = var.tier
  memory_size_gb          = var.memory_size_gb
  region                  = var.region
  redis_version           = var.db_version
  location_id             = var.primary_location_zone == "" ? null : var.primary_location_zone
  alternative_location_id = var.alternative_location_zone == "" ? null : var.alternative_location_zone
  authorized_network      = var.vpc_network
  connect_mode            = var.connect_mode
  read_replicas_mode      = var.enable_read_replicas == "true" ? "READ_REPLICAS_ENABLED" : "READ_REPLICAS_DISABLED"
  labels                  = var.labels
  transit_encryption_mode = "SERVER_AUTHENTICATION"
}