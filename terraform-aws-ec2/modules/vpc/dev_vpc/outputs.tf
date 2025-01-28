output "vpc_id" {
value = data.aws_vpc.selected.id
}

output "subnet_id" {
    #value = data.aws_subnets.public_subnets.ids
    value = local.selected_subnets
}


