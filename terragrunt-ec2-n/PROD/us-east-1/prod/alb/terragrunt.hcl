locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Extract out common variables for reuse
  env           = local.environment_vars.locals.environment
  domain_name   = local.account_vars.locals.domain_name
  owner         = local.account_vars.locals.owner
  instance_type = local.environment_vars.locals.instance_type
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../../../terragrunt-ec2-modules/alb/prod_alb"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "ec2" {
  config_path = "../ec2"
  mock_outputs = {
    cluster_id     = "arn:aws:ecs:us-east-1:067653612345:cluster/app-qa"
    instance_role  = "app-qa-instance-role"
    instance_sg_id = "sg-05d46f4416d012345"
    vectre_instance_id = "i-073f5fbc81e9a45687"
    second_instance_id = "i-073f5fbc81e9a49688"
  }
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_prod = "vpc-012341a0dd8b01234",
    prod_subnets = [
        "subnet-003601fe683fd1114",
      "subnet-0f0787cffc6ae1114",
      "subnet-00e05034aa90b1114"
    ]
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name          = "app-${local.env}"
  tags = {
    Environment = "${local.env}"
    Owner       = "${local.owner}"
  }
  version      = "~> 1.0.9"
  vpc_id         = dependency.vpc.outputs.vpc_prod
  public_subnets = dependency.vpc.outputs.prod_subnets
  domain         = "domain.name"
  vectre_instance_id = dependency.ec2.outputs.vectre_instance_id
  second_instance_id = dependency.ec2.outputs.second_instance_id
}