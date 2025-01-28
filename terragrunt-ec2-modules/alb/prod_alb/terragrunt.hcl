dependency "vpc" {
  config_path = "../vpc/prod_vpc"
}

dependency "ec2" {
  config_path = "../ec2/prod_ec2"
}

inputs = {
  vpc_id        = dependency.vpc.outputs.vpc_id
  public_subnets = dependency.vpc.outputs.public_subnets
}