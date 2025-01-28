variable "vpc_id" {
    type = string
}

variable "public_subnets" {
  type = list(string)
}


variable "name" {
type = string
}


variable "domain" {
  type = string
}


variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}


variable "vectre_instance_id" {
  type = string 
}

variable "second_instance_id" {
  type = string
}
