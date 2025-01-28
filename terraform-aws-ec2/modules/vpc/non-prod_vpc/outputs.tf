


output "non_prod" {
    value = local.non_prod_subnets
}

output  "vpc_non_prod" {
    value = data.aws_vpc.vpc_non_prod.id
}

