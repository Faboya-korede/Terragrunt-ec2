output "prod_subnets" {
    value = local.prod_subnets
}



output  "vpc_prod" {
    value = data.aws_vpc.vpc_prod.id
}