# VarhaviX Operations Runbook

## Deployment

### Docker Compose (Dev/Staging)
```bash
cd vx_core_system_orchestrator
./vx-orchestrate.sh pull
./vx-orchestrate.sh build
./vx-orchestrate.sh up
./vx-orchestrate.sh status
```

### Kubernetes (Production)
```bash
cd vx_infra_foundation/k8s/overlays/prod
kustomize build . | kubectl apply -f -
kubectl rollout status -n varhavix deployment --timeout=300s
```

## Health Checks
| Service | Endpoint | Port |
|:---|:---|:---|
| Landing API | `/api/v1/health` | 8080 |
| LMS API | `/api/v1/health` | 8081 |
| Mind Mapper API | `/api/v1/health` | 8082 |
| Admin API | `/api/v1/health` | 8084 |
| Mentor API | `/api/v1/health` | 8085 |
| Media API | `/api/v1/health` | 8086 |

## Rollback
```bash
# K8s
kubectl rollout undo -n varhavix deployment/<name>

# Docker Compose
./vx-orchestrate.sh down
git checkout <previous-tag>
./vx-orchestrate.sh build && ./vx-orchestrate.sh up
```
