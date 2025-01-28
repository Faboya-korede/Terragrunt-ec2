

output "non_prod_subnets" {
  value = module.vpc.non_prod
}


output "vpc_non_prod" {
  value = module.vpc.vpc_non_prod
}
