provider "aws" {
    region = var.regionx  
}

module "vpc" {
  source = "../../Modules/vpc"

  cidr_block = var.cidr_block
  subnets = var.subnets
  availabilty_zones = var.availabilty_zones
  # public_subnet_id = var.public_subnet_id
}



module "ec2" {
  source = "../../Modules/ec2"

  ami_id = var.ami_id
  instance_type = var.instance_type
  subnet_id = module.vpc.subnet_ids[0]
  key_name = var.key_name
  allowed_ports = var.allowed_ports
  allowed_cidr_blocks = var.allowed_cidr_blocks
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

