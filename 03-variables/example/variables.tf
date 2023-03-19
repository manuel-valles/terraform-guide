variable "instance_name" {
  description = "Terraform Guide EC2"
  type        = string
}

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

variable "db_user" {
  description = "Username for RDS"
  type        = string
  default     = "manu"
}

variable "db_pass" {
  description = "Password for RDS"
  type        = string
  sensitive   = true
}
