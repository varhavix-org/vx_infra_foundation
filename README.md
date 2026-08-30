# vx_infra_foundation

**VarhaviX Enterprise Infrastructure Foundation** — Generic, extensible IaC and DevOps.

## Structure

```
├── docker/           Container templates (Spring Boot, Angular, Node, Python)
├── iac/              Terraform modules + environment configs
├── k8s/              Kustomize-based Kubernetes manifests
├── ci-cd/            Reusable GitHub Actions workflows
├── monitoring/       Prometheus, Grafana, alerting rules
├── config/           Environment variables + app registry
└── docs/             Architecture, runbook, disaster recovery
```

## Quick Start

```bash
# Local development
cd docker/compose
docker compose -f docker-compose.base.yml up -d

# Deploy to K8s
cd k8s/overlays/dev
kustomize build . | kubectl apply -f -

# Provision cloud infra
cd iac/terraform/environments/dev
terraform init && terraform apply
```

## Adding a New App
1. Add to `config/registry.yml`
2. Add DB to `iac/scripts/init-databases.sql`
3. Use a Dockerfile template from `docker/templates/`
4. Add Prometheus scrape target in `monitoring/prometheus/prometheus.yml`
