# General Variables
variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "eu-west-2"
}

# EC2 Variables
variable "ami" {
  description = "Amazon machine image to use for EC2 instance"
  type        = string
  default     = "ami-0f5470fce514b0d36" # Amazon Limux 2023 # eu-west-2 
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# S3 Variables
variable "bucket_prefix" {
  description = "Prefix of S3 bucket for app data"
  type        = string
}

# RDS Variables
variable "db_name" {
  description = "Name of RDS"
  type        = string
}

variable "db_user" {
  description = "Username for RDS"
  type        = string
}

variable "db_pass" {
  description = "Password for RDS"
  type        = string
  sensitive   = true
}
