# =======================================================================
# VarhaviX PROD Environment
# =======================================================================

terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = { source = "hashicorp/aws"; version = "~> 5.0" }
  }
  backend "s3" {
    bucket = "varhavix-terraform-state"
    key    = "prod/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" { region = "ap-south-1" }

module "networking" {
  source      = "../../modules/networking"
  environment = "prod"
}

module "database" {
  source         = "../../modules/database"
  environment    = "prod"
  vpc_id         = module.networking.vpc_id
  subnet_ids     = module.networking.private_subnet_ids
  instance_class = "db.r6g.large"
}

module "compute" {
  source        = "../../modules/compute"
  environment   = "prod"
  vpc_id        = module.networking.vpc_id
  subnet_ids    = module.networking.private_subnet_ids
  desired_nodes = 5
}

module "cache" {
  source     = "../../modules/cache"
  environment = "prod"
  subnet_ids  = module.networking.private_subnet_ids
}

module "storage" {
  source      = "../../modules/storage"
  environment = "prod"
}

module "monitoring" {
  source      = "../../modules/monitoring"
  environment = "prod"
}
