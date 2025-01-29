# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
  account_name = "stage"
  aws_profile  = "your-aws-profile"
  domain_name  = "korede.tech"
  owner        = "me"
}
