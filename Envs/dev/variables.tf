variable "regionx" {
    description = "Aws region"
    type = string
    default = "us-east-1"  
}

# variable "cidr_block" {
#   description = "aws cidr block"
#   type = string
# }

# variable "subnets" {
#   description = "dev subnet"
#   type = list(string)
# }

# variable "availability_zones" {
#   description = "azs fo dev"
#   type = list(string)
# }

# variable "ami_id" {
#   description = "dev ami id"
#   type = string  
# }

# variable "instance_type" {
#   description = "instance type"
#   type = string
# }


# # Rds
# variable "allocated_storage" {
#     description = "size the db in GB"
#     type = number
# }

# variable "storage_type" {
#   description = "storage type"
#   type = string
# }

# variable "engine" {
#   description = "DB engine to use -- "
#   type =  string
# }

# variable "engine_version" {
#   description = "the version of the db"
#   type = string
# }

# variable "instance_class" {
#   description = "the compute and memory capacity"
#   type = string
# }

# variable "db_identifier" {
#     description = "the identifier"
#     type = string  
# }

# variable "username" {
#     description = "username for the DB"
#     type = string
# }

# variable "password" {
#   description = "password for the DB"
#   type = string
#   sensitive = true
# }

# variable "parameter_group_name" {
#     description = "parameter group to associate with"
  
# }

# # s3

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

# variable "key_name" {
#   description = "key fname for grafana"
#   type = string
# }

# variable "allowed_ports" {
#   description = "list of ports inbound"
#   type = list(number)
  
# }

# variable "allowed_cidr_blocks" {
#   description = "CIDR blocks allowed to access the instance"
#   type = list(string)  
# }

# variable "public_subnet_id" {
#   description = "The ID of the public subnet to associate with the route table"
#   type        = string
# }


# envs/dev/variables.tf

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a"]
}

variable "project_name" {
  type    = string
  default = "pract"
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type = string
}

variable "allowed_ports" {
  type = list(number)
  default = [22, 3000, 9090]
}

variable "allowed_cidr_blocks" {
  type = list(string)
  default = ["0.0.0.0/0"]
}
