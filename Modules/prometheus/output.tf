output "prometheus_url" {
  value = "http://${aws_instance.prometheus.public_dns}:9090"
}