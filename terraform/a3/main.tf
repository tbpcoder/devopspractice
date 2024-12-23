module "vpc" {
  source = "./modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
}

module "subnets" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id
  subnet_cidr_block = var.subnet_cidr_block
}

module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source = "./modules/route_table"
  vpc_id              = module.vpc.vpc_id
  igw_id              = module.internet_gateway.igw_id
  subnet_id          = module.vpc.subnet_id
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  instance_type   = var.instance_type
  subnet_id       = module.vpc.subnet_id
  sg_id           = module.security_group.sg_id
}