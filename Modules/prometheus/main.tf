resource "aws_instance" "prometheus" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
  instance_type = "t3.micro"
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo systemctl start docker
              sudo systemctl enable docker
              docker run -d \
                -p 9090:9090 \
                --name prometheus \
                prom/prometheus
              EOF

  tags = {
    Name = "prometheus-server"
  }
}


