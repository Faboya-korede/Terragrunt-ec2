output "cluster_endpoint" {
  value = module.aurora.cluster_endpoint
}

output "reader_endpoint" {
  value = module.aurora.reader_endpoint
}

output "database_name" {
  value = module.aurora.database_name
  sensitive = true
}