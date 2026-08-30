# =======================================================================
# VarhaviX DEV Environment
# =======================================================================

terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = { source = "hashicorp/aws"; version = "~> 5.0" }
  }
  backend "s3" {
    bucket = "varhavix-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" { region = "ap-south-1" }

module "networking" {
  source      = "../../modules/networking"
  environment = "dev"
}

module "database" {
  source         = "../../modules/database"
  environment    = "dev"
  vpc_id         = module.networking.vpc_id
  subnet_ids     = module.networking.private_subnet_ids
  instance_class = "db.t3.micro"
}

module "compute" {
  source        = "../../modules/compute"
  environment   = "dev"
  vpc_id        = module.networking.vpc_id
  subnet_ids    = module.networking.private_subnet_ids
  desired_nodes = 2
}

module "cache" {
  source     = "../../modules/cache"
  environment = "dev"
  subnet_ids  = module.networking.private_subnet_ids
}

module "storage" {
  source      = "../../modules/storage"
  environment = "dev"
}

module "monitoring" {
  source      = "../../modules/monitoring"
  environment = "dev"
}
