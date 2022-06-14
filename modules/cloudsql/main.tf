locals {
  public          = var.ipv4_enabled == "true" && var.private_network == "" ? "true" : "false"
  disk_autoresize = var.disk_size == null && var.disk_autoresize == "true" ? "true" : "false"
  # for postgres database only. all will have point in time recovery in case of disaster recovery scenario
  point_in_time_recovery = substr(var.db_version,0, 4) == "POST" ? true : null
  
}

resource "google_sql_database_instance" "db" {
  database_version    = var.db_version
  project             = var.project_id
  name                = lower("${var.db_instance}")
  region              = var.region
  deletion_protection = var.deletion_protection
  
  settings {
    availability_type = var.availability_type
    tier              = substr(var.db_version, 0, 9) == "SQLSERVER" ? var.custom_db_tier : var.instance_tier
    disk_type         = var.disk_type
    disk_size         = var.disk_size
    disk_autoresize   = local.disk_autoresize

    ip_configuration {
      ipv4_enabled    = local.public
      private_network = var.private_network
      require_ssl     = true
    }

    backup_configuration {
      start_time                     = var.backup_start_time
      enabled                        = true
      binary_log_enabled             = var.backup_binary_log_enabled
      point_in_time_recovery_enabled = local.point_in_time_recovery
    }

    maintenance_window {
      day  = var.maintenance_window_day
      hour = var.maintenance_window_hour
    }

    dynamic "database_flags" {
      iterator = flag
      for_each = var.database_flags

      content {
        name  = flag.key
        value = flag.value
      }
    }
  }
}

resource "google_sql_database" "default" {
  name       = lower("${var.db_name}")
  project    = var.project_id
  instance   = google_sql_database_instance.db.name
  depends_on = [google_sql_database_instance.db]
}

resource "google_sql_ssl_cert" "client_cert" {
  instance    = google_sql_database_instance.db.name
  project     = var.project_id
  common_name = "default-client-cert"
  depends_on  = [google_sql_database_instance.db]
}

