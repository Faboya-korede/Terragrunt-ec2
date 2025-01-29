# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
  account_name = "DEV"
  aws_account_id  = "654654233014"
  app_name  = "ECS"
  domain_name  = "IT.Security"
  owner        = "me"
  aws_profile  = "basil"
}
