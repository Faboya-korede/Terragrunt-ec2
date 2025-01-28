
data "aws_vpc" "vpc_prod" {
    id = var.vpc_prod
}



locals {
  # Hardcoding the subnet IDs and making sure they are from different AZs
  prod_subnets = [
    "subnet-0f8e0b97cc8f3c124",  # Subnet 1 in AZ 1
    "subnet-0acb39ac631e0ef3c",  # Subnet 2 in AZ 2
    "subnet-027efc80880764275"   # Subnet 3 in AZ 3
  ]
}
