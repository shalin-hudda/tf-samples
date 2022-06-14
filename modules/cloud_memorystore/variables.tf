variable "db_instance" {
  description = "the instance name"
  type = string
  default = ""
}

variable "tier" {
  description = "redis tier BASIC or STANDARD_HA"
  type = string
  default = "BASIC"
}

variable "memory_size_gb" {
  description = "size of the db in gb"
  type = string
  default = "1"
}

variable "region" {
  description = "GCP region for the db"
  type = string
  default = ""
}

variable "db_version" {
  description = "redis version"
  type = string
  default = "REDIS_4_0"
}

variable "primary_location_zone" {
  description = "primary location when manually configuring zones for HA"
  type = string
  default = ""
}

variable "alternative_location_zone" {
  description = "alertative location when manually configuring zones for HA"
  type = string
  default = ""
}

variable "vpc_network" {
  description = "GCP VPC network"
  type = string
  default = ""
}

variable "connect_mode" {
  description = "the mode you want to use to connect PRIVATE_SERVICE_ACCESS or DIRECT_PEERING"
  type = string
  default = "PRIVATE_SERVICE_ACCESS"
}

variable "enable_read_replicas" {
  description = "bool to enable read replicas"
  type    = bool
  default = false
}

variable "labels" {
  description = "labels that should be added to the instance"
  type = map
  default = {}
}
