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
  source = "../../../../../terragrunt-ec2-modules/aurora/dev_aurora"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "ec2" {
  config_path = "../ec2"
  mock_outputs = {
    vectre_instance_sg = "i-073f5fbc81e9a45687"
  }
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id = "vpc-012341a0dd8b01234",
    public_subnets = [
        "subnet-003601fe683fd1114",
      "subnet-0f0787cffc6ae1114",
      "subnet-00e05034aa90b1114"
    ]
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name          = "deluxe-ec2-${local.env}"
  tags = {
    Environment = "${local.env}"
    Owner       = "${local.owner}"
  }
  version      = "~> 1.0.9"
  vpc_id         = dependency.vpc.outputs.vpc_id
  public_subnets = dependency.vpc.outputs.public_subnets
  vectre_instance_sg = dependency.ec2.outputs.vectre_instance_sg
  db_name = "vectr_db"
  db_username = "vectr"
  db_password = "password"
}