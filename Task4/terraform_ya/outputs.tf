output "database_host" {
  description = "PostgreSQL host for connections"
  value       = yandex_mdb_postgresql_cluster.finance_oltp.host[0].fqdn
}

output "database_port" {
  description = "PostgreSQL port"
  value       = 6432
}

output "database_name" {
  description = "Database name"
  value       = var.db_name
}

output "connection_string" {
  description = "Full connection string (sensitive)"
  value       = "postgresql://${var.db_username}:${var.db_password}@${yandex_mdb_postgresql_cluster.finance_oltp.host[0].fqdn}:6432/${var.db_name}"
  sensitive   = true
}

output "environment" {
  description = "Current environment"
  value       = var.environment
}

output "database_disk_size" {
  description = "Actual disk size being used"
  value       = var.environment == "production" ? var.db_prod_disk_size : var.db_disk_size
}