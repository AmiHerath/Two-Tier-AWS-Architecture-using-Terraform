module "vpc" {
  source        = "./modules/vpc"
  vpc_cidr      = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "web" {
  source          = "./modules/web"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  instance_type   = var.web_instance_type
  ami_id          = var.web_ami
  key_name        = var.key_name
  }

module "db" {
  source          = "./modules/db"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  db_name         = var.db_name
  db_username     = var.db_username
  db_password     = var.db_password
  instance_type   = var.db_instance_type
  web_sg_id       = module.web.web_sg_id
}
