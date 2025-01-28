variable "name" {
  type = string
}

variable "db_name" {
  description = "database name"
  type = string
  sensitive = true
}
variable "db_username" {
  description = "Database master username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "public_subnets" {
  description = "List of subnet IDs for the database"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where the database will be created"
  type        = string
}

variable "vectre_instance_sg" {
  description = "Security group ID of the application"
  type        = string
}

