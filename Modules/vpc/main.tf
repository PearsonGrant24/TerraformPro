resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.proApp_project}-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.proApp_project}-igw"
  }
}

# Public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.proApp_project}-public-rt"
  }
}

# Subnets (public or private depending on flag)
resource "aws_subnet" "subnet" {
  count = length(var.subnets)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.subnets, count.index)
  availability_zone       = element(var.availabilty_zones, count.index)
  map_public_ip_on_launch = var.public_subnet[count.index] # ✅ controls if public IP is auto-assigned

  tags = {
    Name = "${var.proApp_project}-subnet-${count.index}"
  }
}

# Associate public subnets with public route table
resource "aws_route_table_association" "public_assoc" {
  count          = length(var.subnets)
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.public.id

  # Only for public subnets
  lifecycle {
    ignore_changes = [subnet_id]
  }

  depends_on = [aws_internet_gateway.igw]
}
