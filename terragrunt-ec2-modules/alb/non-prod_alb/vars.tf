variable "module_version" {
  description = "Version of the terraform module"
  type        = string
  default     = "1.0.9"
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "VPC ID to create cluster in"
}

variable "public_subnets" {
  description = "List of VPC subnets to put instances in"
  type        = list(string)
}

variable "domain" {
  type = string
}

variable "vectre_instance_id" {
  type = string
}

variable "second_instance_id" {
  type = string
}