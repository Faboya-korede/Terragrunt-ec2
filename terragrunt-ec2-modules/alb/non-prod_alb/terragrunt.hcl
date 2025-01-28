dependency "vpc" {
  config_path = "../vpc/non-prod_vpc"
}

dependency "ec2" {
  config_path = "../ec2/non-prod_ec2"
}

inputs = {
  vpc_id        = dependency.vpc.outputs.vpc_id
  public_subnets = dependency.vpc.outputs.public_subnets
}