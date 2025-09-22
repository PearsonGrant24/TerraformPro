output "vpc_id" {
    value = aws_vpc.main.id  
}

output "subnets_ids" {
    value = aws_subnet.subnet[*].id
  
}

output "public_subnet_ids" {
#   value = aws_subnet.public[*].id
    value = aws_subnet.subnet[*].id
}
