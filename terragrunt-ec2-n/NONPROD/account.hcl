# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
  account_name = "stage"
  aws_profile  = "default"
  domain_name  = "korede.tech"
  owner        = "me"
}
