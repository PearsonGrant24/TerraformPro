# Region
regionx           = "us-east-1"

# VPC + Subnets
cidr_block        = "10.2.0.0/16"
public_subnets  = ["10.2.1.0/24", "10.2.2.0/24"]
private_subnets = ["10.2.3.0/24", "10.2.4.0/24"]
availability_zones = ["us-east-1a" , "us-east-1b"]

# EC2 Instance
ami_id            = "ami-08982f1c5bf93d976"
instance_type     = "t3.medium"
key_name          = "NewKey"

# Security Group rules
allowed_ports       = [22, 3000, 9090]
allowed_cidr_blocks = ["0.0.0.0/0"]

# Project Tag
project_name        = "dev-environment"

# bucket
bucket_name         = "pract-dev-website"