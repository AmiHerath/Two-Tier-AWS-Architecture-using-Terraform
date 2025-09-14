# AWS region
variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

# VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# Web tier
variable "web_instance_type" {
  default = "t3.micro"
}

variable "web_ami" {
  description = "Amazon Linux 2023 AMI"
  default     = "ami-0b09ffb6d8b58ca91"
}

# Database tier
variable "db_instance_type" {
  default = "db.t3.micro"
}

variable "db_name" {
  default = "mydb"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  description = "RDS master user password"
  type        = string
  sensitive   = true
  default     = "MyS3curePasword123"
  }

variable "key_name" {
    description = "value for key_name"
}

