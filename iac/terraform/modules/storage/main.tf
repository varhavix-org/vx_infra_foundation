# =======================================================================
# VarhaviX Storage Module — S3 Buckets
# =======================================================================

variable "project_name" { type = string; default = "varhavix" }
variable "environment" { type = string }

resource "aws_s3_bucket" "media" {
  bucket = "${var.project_name}-${var.environment}-media"
  tags = {
    Name        = "${var.project_name}-${var.environment}-media"
    Environment = var.environment
  }
}

resource "aws_s3_bucket" "backups" {
  bucket = "${var.project_name}-${var.environment}-backups"
  tags   = { Environment = var.environment }
}

resource "aws_s3_bucket_versioning" "media" {
  bucket = aws_s3_bucket.media.id
  versioning_configuration { status = "Enabled" }
}

output "media_bucket" { value = aws_s3_bucket.media.bucket }
output "backups_bucket" { value = aws_s3_bucket.backups.bucket }
