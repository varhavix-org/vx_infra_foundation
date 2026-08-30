# =======================================================================
# VarhaviX Cache Module — ElastiCache Redis
# =======================================================================

variable "project_name" { type = string; default = "varhavix" }
variable "environment" { type = string }
variable "subnet_ids" { type = list(string) }
variable "node_type" { type = string; default = "cache.t3.micro" }

resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.project_name}-${var.environment}-redis-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.project_name}-${var.environment}-redis"
  engine               = "redis"
  engine_version       = "7.1"
  node_type            = var.node_type
  num_cache_nodes      = 1
  subnet_group_name    = aws_elasticache_subnet_group.main.name

  tags = {
    Name        = "${var.project_name}-${var.environment}-redis"
    Environment = var.environment
  }
}

output "redis_endpoint" { value = aws_elasticache_cluster.redis.cache_nodes[0].address }
