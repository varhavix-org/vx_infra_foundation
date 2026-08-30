#!/usr/bin/env bash
# =======================================================================
# VarhaviX Infrastructure Bootstrap
# First-time setup for new environments
# =======================================================================
set -euo pipefail

echo "🚀 VarhaviX Infrastructure Bootstrap"
echo "======================================"

ENV=${1:-dev}
echo "Environment: $ENV"

# Initialize Terraform
cd "$(dirname "$0")/../terraform/environments/$ENV"
terraform init
terraform validate
echo "✅ Terraform initialized for $ENV"

# Create databases
echo "Creating databases..."
psql -h localhost -U postgres -f "$(dirname "$0")/init-databases.sql" 2>/dev/null || echo "⚠️ Databases may already exist"

echo "✅ Bootstrap complete for $ENV"
