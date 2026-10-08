# Meridian Labs Infrastructure

OpenTofu project that provisions a VPC, an EC2 instance and an S3 bucket, using
[LocalStack](https://localstack.cloud) in place of real AWS.

## Quick start

```bash
docker compose up -d                # start LocalStack
bash scripts/bootstrap-state.sh     # create the remote-state bucket
tofu init                           # configure the S3 backend
tofu plan
tofu apply
```

## Layout

| File | Purpose |
|------|---------|
| `versions.tf` | OpenTofu and provider version constraints |
| `providers.tf` | AWS provider pointed at LocalStack |
| `backend.tf` | Remote state in a LocalStack S3 bucket |
| `variables.tf` | Input variable declarations |
| `terraform.tfvars` | Values for those variables |
| `main.tf` | Resources (VPC, EC2, S3) |
| `outputs.tf` | Values exported after apply |
| `docker-compose.yml` | Runs LocalStack locally |
| `scripts/bootstrap-state.sh` | Creates the state bucket |
| `.github/workflows/infra.yml` | CI/CD: plan on PR, apply on merge to main (needs the `LOCALSTACK_AUTH_TOKEN` repo secret) |
