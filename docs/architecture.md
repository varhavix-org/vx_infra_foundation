# VarhaviX Infrastructure Architecture

## Overview
```
                    ┌─────────────────────────────────────────┐
                    │           Nginx Gateway (:80)            │
                    └────────────────┬────────────────────────┘
                                     │
              ┌──────────────────────┼──────────────────────┐
              │                      │                      │
     ┌────────┴───────┐    ┌────────┴───────┐    ┌────────┴───────┐
     │   UI Apps       │    │   API Apps      │    │  Monitoring    │
     │  Landing :4200  │    │  Landing :8080  │    │  Prometheus    │
     │  LMS     :4205  │    │  LMS     :8081  │    │  Grafana       │
     │  Admin   :4201  │    │  Mapper  :8082  │    └────────────────┘
     │  Mentor  :4202  │    │  Admin   :8084  │
     │  Mapper  :4203  │    │  Mentor  :8085  │
     │  Media   :4204  │    │  Media   :8086  │
     └────────────────┘    └────────┬───────┘
                                     │
                          ┌──────────┴──────────┐
                          │ PostgreSQL  │ Redis  │
                          │   :5432     │ :6379  │
                          └─────────────────────┘
```

## Directory Structure
- `docker/` — Container image templates and compose files
- `iac/` — Terraform modules and environment configs
- `k8s/` — Kustomize-based Kubernetes manifests
- `ci-cd/` — Reusable GitHub Actions workflows
- `monitoring/` — Prometheus, Grafana, alerting
- `config/` — Environment variables and app registry
- `docs/` — This documentation

## Adding a New App
1. Add entry to `config/registry.yml`
2. Add database to `iac/scripts/init-databases.sql`
3. Add scrape target to `monitoring/prometheus/prometheus.yml`
4. Create Kustomize overlay patch if needed
