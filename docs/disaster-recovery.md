# VarhaviX Disaster Recovery Plan

## RTO/RPO Targets
| Tier | RTO | RPO |
|:---|:---|:---|
| Database | 1 hour | 5 minutes |
| Application | 15 minutes | 0 (stateless) |
| Media Assets | 4 hours | 24 hours |

## Backup Strategy
- **PostgreSQL**: Automated daily snapshots via RDS, WAL archiving for PITR
- **Redis**: AOF persistence, periodic RDB dumps
- **S3 Media**: Cross-region replication enabled
- **Terraform State**: Versioned S3 backend with DynamoDB locking

## Recovery Procedures
1. **Database Failure**: Restore from latest RDS snapshot → verify with health checks
2. **Complete Cluster Loss**: `terraform apply` from state → `kustomize build | kubectl apply`
3. **Single Service Failure**: `kubectl rollout restart -n varhavix deployment/<name>`
