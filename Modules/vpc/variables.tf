variable "cidr_block" {
    description = "cidr block for tthe vpc"
    type = string
}

variable "subnets" {
  description = "list  of subnets"
  type = list(string)
}

variable "availabilty_zones" {
  description = "list of AZs"
  type = list(string)
}

variable "project_name" {
  description = "Name prefix for resources (used in tags)"
  type        = string
  default     = "practice-project"  # you can override in dev/terraform.tfvars
}

variable "public_subnet_id" {
  description = "The ID of the public subnet to associate with the route table"
  type        = string
}
