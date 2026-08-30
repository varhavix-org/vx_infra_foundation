# =======================================================================
# VarhaviX Database Module — RDS PostgreSQL
# =======================================================================

variable "project_name" { type = string; default = "varhavix" }
variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "instance_class" { type = string; default = "db.t3.medium" }
variable "allocated_storage" { type = number; default = 50 }

resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-${var.environment}-db-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "postgres" {
  identifier             = "${var.project_name}-${var.environment}-postgres"
  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  storage_encrypted      = true
  db_subnet_group_name   = aws_db_subnet_group.main.name
  multi_az               = var.environment == "prod" ? true : false
  backup_retention_period = var.environment == "prod" ? 30 : 7
  skip_final_snapshot    = var.environment != "prod"

  tags = {
    Name        = "${var.project_name}-${var.environment}-postgres"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

output "db_endpoint" { value = aws_db_instance.postgres.endpoint }
output "db_port" { value = aws_db_instance.postgres.port }
