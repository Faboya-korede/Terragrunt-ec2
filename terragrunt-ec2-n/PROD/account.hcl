# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
  account_name = "prod"
  aws_profile  = "your-aws-profile"
  domain_name  = "mydomain.io"
  owner        = "me"
}
