# the instance_address is equivalent to the ip_address
output "instance_ip" {
  description = "private instance IP"
  value = google_sql_database_instance.db.ip_address
}

# # the instance_id is equivalent to the connection_name
output "instance_id" {
  description = "the connection namewhich can be used to connect to the database"
  value = google_sql_database_instance.db.connection_name
}

# the database server name
output "instance_name" {
  description = "the instance name"
  value = var.db_instance
}

# database name
output "db_name" {
  description = "the database name inside the instance"
  value = var.db_name
}

# instance service account email address
output "service_account_email_address" {
  description = "the default service account address used by CloudSQL db"
  value = google_sql_database_instance.db.service_account_email_address
}