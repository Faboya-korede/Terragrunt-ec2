output "vectre_instance_id" {
  value = aws_instance.vectre_instance.id
}


output "second_instance_id" {
  value = aws_instance.second_instance.id
}

output "vectre_instance_sg" {
  value = aws_security_group.vectre_instance_sg.id
}