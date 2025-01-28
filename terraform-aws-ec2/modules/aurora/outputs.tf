# Outputs
output "cluster_endpoint" {
  value = aws_rds_cluster.aurora_cluster.endpoint
}

output "reader_endpoint" {
  value = aws_rds_cluster.aurora_cluster.reader_endpoint
}

output "database_name" {
  value = aws_rds_cluster.aurora_cluster.database_name
  sensitive = true
}