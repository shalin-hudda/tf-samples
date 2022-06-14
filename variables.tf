variable "gcp_project_id" {
    description = "GCP project id"
    type        = string
    default     = ""
}

variable "region" {
    description = "GCP region"
    type        = string
    default     = ""
}

variable "zone" {
    description = "GCP zone"
    type        = string
    default     = ""
}

variable "vpc_network" {
    description = "GCP project VPC network"
    type        = string
    default     = ""
}

variable "subnetwork" {
    description = "VPC subnetwork"
    type        = string
    default     = ""
}

variable "cloudsql_instance_name" {
    description = "cloudsql instance name"
    type        = string
    default     = ""
}

variable "cloudsql_db_name" {
    description = "cloudsql database name"
    type        = string
    default     = ""
}

variable "cloudsql_backup_start_time_hour_minute" {
    description = "cloudsql backup start name"
    type        = string
    default     = ""
}

variable "cloudsql_disk_size" {
    description = "cloudsql disk size"
    type        = string
    default     = ""
}

variable "memorystore_size_gb" {
    description = "memorystore disk size in gb"
    type        = string
    default     = "1"
}

variable "memorystore_instance_name" {
    description = "memorystore instance name"
    type        = string
    default     = ""
}

variable "cluster_name" {
    description = "cluster name"
    type        = string
    default     = ""
}

variable "maintenance_window_day" {
    description = "maintenance window day"
    type        = string
    default     = "7"
}

variable "maintenance_window_hour" {
    description = "maintenance window hour"
    type        = string
    default     = "09"
}

variable "maintenance_window_minute" {
    description = "maintenance window minute"
    type        = string
    default     = "00"
}

variable "master_ipv4_cidr_block" {
  description = "the cidr block that needs to be assigned to the master"
  type    = string
  default = "172.23.0.0/28"
}

variable "enable_dataplane_v2" {
    description = "Enable advanced data plane"
    type        = bool
    default     = true
}

variable "gcp_service_list" {
  description ="The list of apis necessary for the project"
  type = list(string)
  default = []
}

variable "cluster_labels" {
    description = "GKE cluster labels"
    type = map
    default = {}
}

variable "master_authorized_source_ranges" {
  description = "the source IPs which are allowed to talk to the GKE master"
  type = list(any)
  default = [
    {
      cidr_block   = "0.0.0.0/0" // Not good for production
      display_name = "Allow all"
    }
  ]
}

variable "cloudrun_config" {
  description = "bool value to indicate if we need to support cloudrun workloads on this cluster"
  type = map(string)

  default = {
    enabled = "false"
  }
}