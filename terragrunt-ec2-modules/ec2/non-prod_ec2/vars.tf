variable "module_version" {
  description = "Version of the terraform module"
  type        = string
  default     = "1.0.0"
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "sub_domain" {
  type = string
}