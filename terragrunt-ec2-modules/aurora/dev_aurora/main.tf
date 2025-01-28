module "aurora" {
  # source = "C:/Users/T476783/Documents/CloudSecurity/terraform/terraform-aws-ec2/modules/alb"
  source = "/Users/macbook/Downloads/deluxe-development-terraform-6f5f94b6b974/terraform-aws-ec2/modules/aurora"

  db_name = var.db_name
  name = var.name
  db_username = var.db_username
  db_password= var.db_password
  public_subnets = var.public_subnets
  vpc_id = var.vpc_id
  vectre_instance_sg = var.vectre_instance_sg
}