output "vpc_id" {
  value = module.vpc.vpc_id
}

# output "public_subnets" {
#   value = module.vpc.public_subnet_ids
# }

# output "private_subnets" {
#   value = module.vpc.private_subnet_ids
# }

# output "ec2_public_ip" {
#   value = module.ec2.monitor_public_ip
# }

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

# output "grafana" {
    
#     value = "http://${module.ec2.instance_id}:3000"
# }

# output "prometheus_url" {
#   value = "http://${module.ec2.instance_id}:9090"
# }


# output "ec2_vpc_id" {
#   description = "VPC ID used by the EC2 instance"
#   value       = module.ec2.subnet_vpc_id
# }

# output "monitor_public_ip" {
#   value = module.ec2.monitor_public_ip
# }