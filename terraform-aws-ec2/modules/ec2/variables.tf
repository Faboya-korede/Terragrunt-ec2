variable "name" {
  description = "Base name to use for resources in the module"
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

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
