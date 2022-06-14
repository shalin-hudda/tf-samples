gcp_project_id = "capstone-wifi-lab"

region = "northamerica-northeast1"

zone = "northamerica-northeast1-a"

vpc_network = "projects/capstone-wifi-lab/global/networks/wifi-lab-network"

subnetwork = "wifi-lab-network"

cluster_name = "autopilot-cluster"

cluster_labels = {
    "autopilot_cluster" = "true"
}

cloudsql_instance_name = "mysql"

cloudsql_db_name = "mysqldb"

cloudsql_backup_start_time_hour_minute = "06:00"

cloudsql_disk_size = "10"

memorystore_size_gb = "1"

memorystore_instance_name = "myredis"

maintenance_window_day = "7"

maintenance_window_hour = "09"

maintenance_window_minute = "00"

gcp_service_list = [
    "serviceusage.googleapis.com", // Using it to be able to read API status
    "servicenetworking.googleapis.com", // Using for CloudSQL when VPC peering is required
    "secretmanager.googleapis.com", // Using for CloudSQL
    "sqladmin.googleapis.com", // to list cloudsql instances
    "container.googleapis.com", // Using it for GKE
    "redis.googleapis.com" // For redis instance
]