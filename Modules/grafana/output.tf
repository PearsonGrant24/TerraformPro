output "grafana_url" {
    description = "value"
    value = "http://${aws_instance.grafana.public_dns}:3000"
  
}