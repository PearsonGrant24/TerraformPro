output "vpc_id" {
  value = aws_vpc.main.id
}

# output "public_subnet_ids" {
# #   value = aws_subnet.public[*].id  bcz we swithced from count
# description = "List of public subnet IDs"
#   value       = [for subnet in aws_subnet.public : subnet.id]
# }

# output "private_subnet_ids" {
#   description = "List of private subnet IDs"
#   value       = [for subnet in aws_subnet.private : subnet.id]
# }
# # value       = values(aws_subnet.private)[*].id           also works (each)


output "subnet_ids" {
  value = aws_subnet.subnet[*].id
}