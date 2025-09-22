provider "aws" {
    region = var.regionx  
}

module "vpc" {
  source = "../../Modules/vpc"

  cidr_block = var.cidr_block
  subnets = var.subnets
  availabilty_zones = var.availabilty_zones
}

module "ec2" {
  source = "../../Modules/ec2"

  ami_id = var.ami_id
  instance_type = var.instance_type
  subnet_id = module.vpc.subnets_ids[0]
  key_name = var.key_name
  allowed_ports = var.allowed_ports
  allowed_cidr_blocks = var.allowed_cidr_blocks

  # vpc_security_group_ids = [module.ec2_sg.id]
  # vpc_security_

}

module "rds" {
    source = "../../Modules/rds"

    db_subnet_ids     = module.vpc.public_subnet_ids
    db_sg_id = module.vpc.aws_db_instance.db_sg_id
    proApp_project = "pract"
    allocated_storage = var.allocated_storage
    storage_type = var.storage_type
    engine = var.engine
    engine_version = var.engine_version
    instance_class = var.instance_class
    db_identifier = var.db_identifier
    username = var.username
    password = var.password
    parameter_group_name = var.parameter_group_name    
    
  
}

module "s3" {
  source = "../../Modules/s3"

  bucket_name = var.bucket_name
  
}

