variable "ami_id" {
  default = ""
  description = "AWS instance ami"
}

variable "instance_type" {
    description = "aws instance type"
    type = string
}

variable "subnet_id" {
    description = "Subnet id for aws ec2 instance"
    type = string  
}

variable "key_name" {
  description = "key fname for grafana"
  type = string
}


variable "allowed_ports" {
  description = "A list f ports allowed inbound traffic on"
  type = list(number)
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the instance"
  type = list(string)
}


