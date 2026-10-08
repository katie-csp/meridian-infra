# AWS provider configured to talk to LocalStack instead of real AWS.
provider "aws" {
  region     = var.aws_region
  access_key = "test" # LocalStack accepts any dummy credentials
  secret_key = "test"

  # Skip checks that would try to reach real AWS
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # LocalStack serves S3 on path-style URLs (http://localhost:4566/bucket)
  s3_use_path_style = true

  endpoints {
    ec2 = var.localstack_endpoint
    s3  = var.localstack_endpoint
    sts = var.localstack_endpoint
  }

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "OpenTofu"
    }
  }
}
