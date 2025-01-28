module "alb" {
   source = "C:/Users/T476783/Documents/CloudSecurity/terraform/terraform-aws-ec2/modules/alb"
  # source = "/Users/macbook/Downloads/deluxe-development-terraform-6f5f94b6b974/terraform-aws-ec2/modules/alb"

  name            = var.name
  tags            = var.tags
  vpc_id          = var.vpc_id
  public_subnets  = var.public_subnets
  domain = var.domain
  vectre_instance_id =var.vectre_instance_id
  second_instance_id =var.second_instance_id
}