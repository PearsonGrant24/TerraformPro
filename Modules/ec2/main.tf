resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-security-group"
  description = "Security Group for Jenkins/Prometheus/Grafana"

  # Dynamically create ingress rules for each port
  ingress = [
    for port in var.allowed_ports : {
      description      = "Ingress for port ${port}"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = var.allowed_cidr_blocks
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_cidr_blocks
  }

  tags = {
    Name = "jenkins-sg"
  }
}



resource "aws_instance" "monitor" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]  # attaching  SG here

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

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    delete_on_termination = true
  }
}
