variable project_id {
  description = "GCP project id"
  type = string

  validation {
      condition = can(regex("[a-z]+", var.project_id))
      error_message = "ERROR: Project ID must not be empty and needs to be a string."
  }
}

variable "region" {
    description = "GCP region"
    type        = string
    default     = ""
}

variable "db_instance" {
    type        = string
    description = "The database instance name"
    validation {
        condition = can(regex("[a-z]+", var.db_instance))
        error_message = "ERROR: Database instance name must not be empty and needs to be a string."
    }
}

variable db_name {
    type        = string
    description = "The database name"
    validation {
        condition = can(regex("[a-z]+", var.db_name))
        error_message = "ERROR: Database name must not be empty and needs to be a string."
    } 
}

variable db_version {
  description = "the db you want to install in CloudSQL"
  type = string
  # available version: 
  # "MYSQL_5_6", "MYSQL_5_7", "MYSQL_8_0" 
  # "POSTGRES_9_6" "POSTGRES_11", "POSTGRES_13"
  # "SQLSERVER_2017_STANDARD"
  validation {
      condition = contains(["MYSQL_8_0", "MYSQL_5_6", "MYSQL_5_7", "POSTGRES_9_6", "POSTGRES_11", "POSTGRES_13", "SQLSERVER_2017_STANDARD"], var.db_version)
      error_message = "ERROR: Database version must be one of the following : MYSQL_5_6, MYSQL_5_7, POSTGRES_9_6, POSTGRES_11, POSTGRES_13, SQLSERVER_2017_STANDARD."
  } 
}

variable "backup_start_time" {
    description = "backup start time"
    type        = string
    default     = "06:00"
}

variable "maintenance_window_day" {
    description = "maintenance window day"
    type        = string
    default     = "7"
}

variable "maintenance_window_hour" {
    description = "maintenance window hour"
    type        = string
    default     = "9"
}

variable backup_binary_log_enabled {
  type = string
  description = "if binary logs should be enabled on the backup"
  default = "true"
}

variable ipv4_enabled {
  type = string
  description = "if you want to use external IP for the database"
  default = "false"
}

variable private_network {
  type    = string
  default = ""
  description = "the VPC network to which you want to deploy the database"
}

variable availability_type {
  type    = string
  default = "ZONAL"
  description = "REGIONAL (HA) CloudSQL or ZONAL instance"
}

variable database_flags {
  type = map
  description = "flags you want to supply to the database such as max_connections"
  default = {}
}

variable disk_type {
  type    = string
  default = "PD_SSD"
  description = "the disk type you want to use with the database"
}

variable disk_size {
  default = null
  type = string
  description = "disk size you want"
}

variable disk_autoresize {
  default = true
  description = "bool to enable disk autoresize"
  type = bool
}

variable deletion_protection {
  default = true
  description = "if you want TF to stop protect from instance deletion"
  type = bool
}

variable instance_tier {
  type    = string
  default = "db-f1-micro"
  description = "the standard (non-custom) machine type you want to use"
}

variable custom_db_tier {
  type    = string
  default = "db-custom-1-3840"
  description = "custom machine type instead of standard"
}