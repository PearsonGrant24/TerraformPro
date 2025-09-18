resource "aws_instance" "monitor" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              # Install Docker
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user

              # Run Prometheus
              docker run -d --name prometheus -p 9090:9090 prom/prometheus

              # Run Grafana
              docker run -d --name=grafana -p 3000:3000 grafana/grafana
              EOF

  tags = {
    Name = "monitoring-instance"
  }
}
