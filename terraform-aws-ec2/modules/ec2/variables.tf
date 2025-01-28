variable "name" {
  description = "Base name to use for resources in the module"
}

variable "vpc_id" {
    type = string
}

variable "public_subnets" {
  type = list(string)
}
