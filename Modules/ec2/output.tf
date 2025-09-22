output "instance_id" {
    value = aws_instance.monitor.id
}

output "grafana_url" {
    description = "value"
    value = "http://${aws_instance.monitor.public_dns}:3000"
  
}

output "prometheus_url" {
  value = "http://${aws_instance.monitor.public_dns}:9090"
}

output "subnet_vpc_id" {
  description = "The VPC ID associated with the selected subnet"
  value       = data.aws_subnet.selected.vpc_id
}
