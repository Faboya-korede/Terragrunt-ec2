dependency "vpc" {
  config_path = "../vpc/dev_vpc"
}

inputs = {
  vpc_id        = dependency.vpc.outputs.vpc_id
  public_subnets = dependency.vpc.outputs.public_subnets
}