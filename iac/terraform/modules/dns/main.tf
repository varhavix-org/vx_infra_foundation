# =======================================================================
# VarhaviX DNS Module — Public & Internal Route53 Hosted Zones
# =======================================================================
variable "public_domain" {
  description = "Public domain accessible on internet"
  type        = string
  default     = "varhavix.com"
}

variable "internal_domain" {
  description = "Internal corporate domain restricted to VPC/VPN"
  type        = string
  default     = "internal.admin.varhavix.com"
}

variable "vpc_id" {
  description = "VPC ID for private hosted zone association"
  type        = string
}

variable "environment" {
  type = string
}

# Public Hosted Zone (varhavix.com)
resource "aws_route53_zone" "public" {
  name = var.public_domain
  tags = {
    Environment = var.environment
    Tier        = "PUBLIC"
  }
}

# Private Hosted Zone (internal.admin.varhavix.com — Resolvable only within VPC/VPN)
resource "aws_route53_zone" "internal" {
  name = "internal.admin.varhavix.com"

  vpc {
    vpc_id = var.vpc_id
  }

  tags = {
    Environment = var.environment
    Tier        = "INTERNAL_VPN"
  }
}

output "public_zone_id" { value = aws_route53_zone.public.zone_id }
output "internal_zone_id" { value = aws_route53_zone.internal.zone_id }
