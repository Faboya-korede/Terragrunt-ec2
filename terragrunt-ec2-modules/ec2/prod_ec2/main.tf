module "ec2" {
  # source = "C:/Users/T476783/Documents/CloudSecurity/terraform/terraform-aws-ec2/modules/ec2"
  source = "/Users/macbook/Downloads/deluxe-development-terraform-6f5f94b6b974/terraform-aws-ec2/modules/ec2"
  name         = var.name
  vpc_id          = var.vpc_id
  public_subnets  = var.public_subnets
}
