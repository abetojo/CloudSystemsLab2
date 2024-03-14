// main.tf

provider "aws" {
  region = "us-east-1"
}

// VPC module
module "vpc" {
  source = "./vpc"
}

// Public subnet module
module "public_subnet" {
  source  = "./public_subnet"
  vpc_id  = module.vpc.vpc_cidr
}

// EC2 module
module "ec2" {
  source      = "./ec2"
  subnet_ids  = module.public_subnet.subnet_ids
}

// Security group module
module "security_group" {
  source = "./security_group"
  vpc_id = module.vpc.vpc_cidr
}