variable "region" {
  type    = string
  default = ""
  description = "the GCP region"
}

variable "project_id" {
  type = string
  description = "the GCP project id"
  default = ""
}

variable "cluster_name" {
  type = string
  description = "the autopilot cluster name"
  default = ""
}

variable "network" {
  type    = string
  description = "the VPC network on which you want to create the cluster"
  default = ""
}

variable "subnetwork" {
  type    = string
  description = "the subnetwork that the cluster should use"
  default = ""
}

variable "pod_secondary_range_name" {
  type    = string
  description = "range for pod IP address space"
  default = ""
}

variable "services_secondary_range_name" {
  type    = string
  description = "range for service IP address space"
  default = ""
}

variable "master_ipv4_cidr_block" {
  type    = string
  description = "the cidr block on which the master nodes should be peered"
  default = "172.23.0.0/28"
}

variable "allow_master_global_access" {
  type    = bool
  description = "bool to allow global access to master"
  default = true
}

variable "maintenance_window_hour" {
  type    = string
  description = "time for maintenance window in hour"
  default = "06"
}

variable "maintenance_window_minute" {
  type    = string
  description = "time for maintenance window in minutes"
  default = "00"
}

variable "master_authorized_source_ranges" {
  type = list(any)
  description = "source ip cidr which are authorized to talk to the master"
  default = []
}

variable "cloudrun_config" {
  type = map(string)
  description = "to enable cloudrun workloads on this cluster"
  default = {
    enabled = "false"
  }
}

variable "http_load_balancing" {
  type = map(string)
  description = "bool to choose if http_load_balancing should be used"
  default = {
    enabled = "true"
  }
}

variable "network_policy" {
  type = map(string)
  description = "bool to enable or disable network policy. note: dataplane v2 does not support network policies"
  default = {
    enabled = "true"
  }
}

variable "release_channel" {
  description = "gke release channel"
  type    = string
  default = "REGULAR"
}

variable "enable_autopilot" {
  description = "if autopilot feature of gke should be enabled"
  type    = bool
  default = false
}

variable "enable_private_endpoint" {
  description = "if gke master should have a private endpoint"
  type    = bool
  default = false
}

variable "load_balancer_type" {
  description = "the type of loadbalancer to create when user creates loadbalancer service"
  type    = string
  default = "LOAD_BALANCER_TYPE_INTERNAL"
}

variable "node_labels" {
  description = "arbitary node labels"
  type    = map(string)
  default = {}
}

variable "resource_labels" {
  description = "arbitary resource labels"
  type    = map(string)
  default = {}
}

variable "enable_dataplane_v2" {
  description = "bool to enable dataplane v2"
  type    = bool
  default = false
}