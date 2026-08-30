provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  default = "us-east-1"
}

resource "aws_vpc" "varhavix_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "varhavix-vpc"
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "16.1"
  instance_class       = "db.t4g.micro"
  db_name              = "varhavix_landing_db"
  username             = "postgres"
  password             = var.db_password
  skip_final_snapshot  = true
}

variable "db_password" {
  description = "PostgreSQL Database Admin Password"
  sensitive   = true
  default     = "SuperSecureVarhavix2026Pass!"
}
