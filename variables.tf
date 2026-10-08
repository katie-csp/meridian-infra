# Input variables. Values can be overridden in terraform.tfvars.

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "localstack_endpoint" {
  description = "URL of the LocalStack edge endpoint"
  type        = string
  default     = "http://localhost:4566"
}

variable "project_name" {
  description = "Name prefix used for all resources"
  type        = string
  default     = "meridian"
}

variable "environment" {
  description = "Deployment environment (e.g. dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI for the EC2 instance (LocalStack provides mock AMIs such as this one)"
  type        = string
  default     = "ami-df5de72bdb3b"
}

variable "bucket_name" {
  description = "Name of the application S3 bucket"
  type        = string
  default     = "meridian-app-bucket"
}
