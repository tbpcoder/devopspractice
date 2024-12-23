provider "null" {}

module "vpc" {
  source = "../common_modules/vpc"
}

module "ec2_instance" {
  source = "../common_modules/ec2"
  depends_on = [module.vpc]
}

module "resource" {
  source = "./resource"
  depends_on = [module.ec2_instance]
}