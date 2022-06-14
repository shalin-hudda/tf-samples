# Enable required GCP services
resource "google_project_service" "gcp_services" {
  for_each = toset(var.gcp_service_list)
  project = var.gcp_project_id
  service = each.key
  disable_dependent_services = true
}

# Create VPC peering for private service connect required for CloudSQL and Cloud Memorystore (redis)
module "private_service_connect" {
  source            = "./modules/service_networking"
  name              = "private-vpc-connection"
  purpose           = "VPC_PEERING"
  address_type      = "INTERNAL"
  prefix_length     = "16"
  vpc_network       = var.vpc_network
}

# Create CloudSQL instance with private IP
module "cloudsql" {
  source                  = "./modules/cloudsql"
  project_id              = var.gcp_project_id
  region                  = var.region
  db_instance             = var.cloudsql_instance_name
  db_name                 = var.cloudsql_db_name
  db_version              = "MYSQL_8_0"
  private_network         = var.vpc_network
  availability_type       = "REGIONAL"
  backup_start_time       = var.cloudsql_backup_start_time_hour_minute
  maintenance_window_hour = var.maintenance_window_hour
  maintenance_window_day  = var.maintenance_window_day
  instance_tier           = "db-n1-standard-1"
  disk_size               = var.cloudsql_disk_size
  deletion_protection     = "false"
  database_flags          = {max_connections = 300}
  depends_on              = [google_project_service.gcp_services, module.private_service_connect.peering]
}

# Generate a random password
resource "random_password" "cloudsql_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Create a Google Managed Secret
resource "google_secret_manager_secret" "cloudsql_secret" {
  secret_id = "cloudsql_password"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
  depends_on = [google_project_service.gcp_services]
}

# Create user with random password
resource "google_sql_user" "cloudsql_user" {
  name       = "cloudsql_default_password"
  instance   = lower("${var.cloudsql_instance_name}")
  password   = random_password.cloudsql_password.result
  depends_on = [module.cloudsql.instance_id]
}

# Store the password in the secret
resource "google_secret_manager_secret_version" "cloudsql_secret_store" {
  secret      = google_secret_manager_secret.cloudsql_secret.id
  secret_data = random_password.cloudsql_password.result
  depends_on  = [google_project_service.gcp_services]
}

# Create a GKE autopilot cluster
module "autopilot_cluster" {
  source                                = "./modules/gke_public_autopilot"
  project_id                            = var.gcp_project_id
  region                                = var.region
  cluster_name                          = var.cluster_name
  network                               = var.vpc_network
  subnetwork                            = var.subnetwork
  enable_autopilot                      = "true"
  master_ipv4_cidr_block                = var.master_ipv4_cidr_block
  allow_master_global_access            = "true"
  enable_dataplane_v2                   = var.enable_dataplane_v2
  resource_labels                       = var.cluster_labels
  master_authorized_source_ranges       = var.master_authorized_source_ranges
  maintenance_window_hour               = var.maintenance_window_hour
  maintenance_window_minute             = var.maintenance_window_minute

  cloudrun_config = {
    enabled = var.cloudrun_config["enabled"]
  }
}

# Create a private redis database
module "cloudmemorystore" {
  source               = "./modules/cloud_memorystore"
  db_instance          = var.memorystore_instance_name
  region               = var.region
  vpc_network          = var.vpc_network
  memory_size_gb       = var.memorystore_size_gb
  enable_read_replicas = true
  connect_mode         = "PRIVATE_SERVICE_ACCESS"
  tier                 = "BASIC"
  depends_on           = [google_project_service.gcp_services, module.private_service_connect.peering]
}

# Provider info
provider "google" {
  region  = var.region
  zone    = var.zone
  project = var.gcp_project_id
}