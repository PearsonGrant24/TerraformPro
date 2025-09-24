regionx             = "us-east-1"
cidr_block          = "10.1.0.0/16"
subnets             = ["10.1.1.0/24" , "10.1.2.0/24"]
availabilty_zones   = ["us-east-1a" , "us-east-1b"]
ami_id              = "ami-0360c520857e3138f"
instance_type       = "t2.medium"
# allocated_storage   = "20"
# storage_type        = "gp2"
# engine              = "mysql"
# engine_version      = "5.7"
# instance_class      = "db.t3.medium"
# db_identifier       = "dev-db"
# username            = "devuser"
# password            = "devpassword"
# parameter_group_name= "default.mysql5.7"
bucket_name         = "pract-dev-website"
key_name            = "NewKey"
allowed_ports       = [22, 3000, 9100, 9090]
allowed_cidr_blocks = ["0.0.0.0/0"]


# # Region
# regionx           = "us-east-1"

# # VPC + Subnets
# cidr_block        = "10.1.0.0/16"
# public_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
# # private_subnets = ["10.1.3.0/24", "10.1.4.0/24"]
# availability_zones = ["us-east-1a" , "us-east-1b"]

# # EC2 Instance
# ami_id            = "ami-08982f1c5bf93d976"
# instance_type     = "t3.medium"
# key_name          = "NewKey"

# # Security Group rules
# allowed_ports       = [22, 3000, 9090]
# allowed_cidr_blocks = ["0.0.0.0/0"]

# # Project Tag
# project_name        = "dev-environment"

# # bucket
# bucket_name         = "pract-dev-website"
