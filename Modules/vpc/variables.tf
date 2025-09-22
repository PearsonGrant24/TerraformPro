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


# true = public subnet, false = private
variable "public_subnet" {
  type        = list(bool)
  default     = [true, false] # first subnet = public, second = private
}

variable "proApp_project" {
    type        = string
    default     = "pract"
}
