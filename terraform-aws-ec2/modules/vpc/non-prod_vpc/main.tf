

data "aws_vpc" "vpc_non_prod" {
    id = var.vpc_non_prod
}



locals {
  # Hardcoding the subnet IDs and making sure they are from different AZs
  non_prod_subnets = [
    "subnet-0541b0a2c29e86b4e",  # Subnet 1 in AZ 1
    "subnet-05e3d99752c136f37",  # Subnet 2 in AZ 2
    "subnet-0c7f20addae4d162a"   # Subnet 3 in AZ 3
  ]
}
