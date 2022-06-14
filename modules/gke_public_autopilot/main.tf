locals {
  cloudrun_disabled              = "false" == var.cloudrun_config["enabled"]
  http_load_balancing_disabled   = "false" == var.http_load_balancing["enabled"]
  node_labels                    = merge({ "cluster-name" = var.cluster_name }, var.node_labels)
}

resource "google_container_cluster" "default" {
  name                     = lower(var.cluster_name)
  location                 = var.region
  network                  = var.network
  subnetwork               = var.subnetwork
  enable_autopilot         = var.enable_autopilot
  datapath_provider        = var.enable_dataplane_v2 ? "ADVANCED_DATAPATH" : "DATAPATH_PROVIDER_UNSPECIFIED"
  resource_labels          = merge(local.node_labels, var.resource_labels)

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
    master_global_access_config {
      enabled = var.allow_master_global_access
    }
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
        for_each = var.master_authorized_source_ranges
        content {
            cidr_block = cidr_blocks.value.cidr_block
            display_name = lookup(cidr_blocks.value, "display_name", null)
        }
    }
   }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "${var.maintenance_window_hour}:${var.maintenance_window_minute}"
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pod_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  addons_config {

    http_load_balancing {
      disabled = local.http_load_balancing_disabled
    }

    cloudrun_config {
      disabled           = local.cloudrun_disabled
      load_balancer_type = var.load_balancer_type
    }
  }

  # Release channel
  release_channel {
    channel = var.release_channel
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  timeouts {
    create = "1h"
    update = "1h"
    delete = "1h"
  }
}