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
