# =======================================================================
# VarhaviX DNS Module — Route53
# =======================================================================

variable "domain_name" { type = string; default = "varhavix.com" }
variable "environment" { type = string }

resource "aws_route53_zone" "main" {
  name = var.environment == "prod" ? var.domain_name : "${var.environment}.${var.domain_name}"
}

output "zone_id" { value = aws_route53_zone.main.zone_id }
output "name_servers" { value = aws_route53_zone.main.name_servers }
