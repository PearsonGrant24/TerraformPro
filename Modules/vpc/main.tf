
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    "name" = "pract-vpc"
  }
}

resource "aws_subnet" "subnet" {
  count = length(var.subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.subnets, count.index)
  availability_zone = element(var.availabilty_zones, count.index)
  
  tags = {
    Name = "pract-subnet-${count.index}"
  }
}