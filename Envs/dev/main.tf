provider "aws" {
    region = var.regionx  
}

module "vpc" {
  source             = "../../Modules/vpc"
  cidr_block         = var.vpc_cidr
  public_subnets     = var.public_subnets       # lists you pass in via tfvars
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
  project_name       = var.project_name
}

# pick a public subnet to use for EC2
locals {
  # pick the first public subnet id (safer: check length before using in production)
  public_subnet_id = length(module.vpc.public_subnet_ids) > 0 ? module.vpc.public_subnet_ids[0] : null
}


# sanity guard (optional): fail early if no public subnet found
# (Uncomment this if you want Terraform to error early)
resource "null_resource" "require_public_subnet" {
  count = local.public_subnet_id == null ? 1 : 0
  provisioner "local-exec" {
    command = "echo 'No public subnet available. Aborting.' && exit 1"
  }
}

module "ec2" {
  source                 = "../../Modules/ec2"
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = local.public_subnet_id     # <-- using local here
  allowed_ports          = var.allowed_ports
  allowed_cidr_blocks    = var.allowed_cidr_blocks
  project_name           = var.project_name
}

# module "rds" {
#     source = "../../Modules/rds"

#     allocated_storage = var.allocated_storage
#     storage_type = var.storage_type
#     engine = var.engine
#     engine_version = var.engine_version
#     instance_class = var.instance_class
#     db_identifier = var.db_identifier
#     username = var.username
#     password = var.password
#     parameter_group_name = var.parameter_group_name    
  
# }

module "s3" {
  source = "../../Modules/s3"

  bucket_name = var.bucket_name
  
}

