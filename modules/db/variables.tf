variable "vpc_id" {}
variable "private_subnets" { type = list(string) }
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "instance_type" {}
variable "web_sg_id" { description = "Security Group ID of web tier" }
