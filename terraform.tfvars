# Environment-specific values for the variables in variables.tf.
# ami_id is deliberately not set here: it uses the default in variables.tf locally,
# and CI overrides it with TF_VAR_ami_id (a value in this file would block that).
aws_region         = "us-east-1"
project_name       = "meridian"
environment        = "dev"
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
instance_type      = "t3.micro"
bucket_name        = "meridian-dev-app-bucket"
