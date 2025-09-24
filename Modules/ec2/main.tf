# Data source to fetch subnet details
data "aws_subnet" "selected" {
  id = var.subnet_id
}


resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-security-group"
  description = "Security Group for Jenkins/Prometheus/Grafana"
  vpc_id      = data.aws_subnet.selected.vpc_id
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
    cidr_blocks = ["0.0.0.0/0"]
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
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash

              sudo apt update -y
              wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
              echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
              sudo apt update -y
              sudo apt install temurin-17-jdk -y
              /usr/bin/java --version

              sudo apt-get update
              sudo apt-get install docker.io -y
              sudo usermod -aG docker ubuntu
              sudo usermod -aG docker jenkins
              newgrp docker
              sudo chmod 777 /var/run/docker.sock
              sudo systemctl restart jenkins
              docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

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
