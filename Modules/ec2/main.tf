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
              set -e
 
              # Update system
              apt-get update -y
              apt-get upgrade -y

              # Install required packages
              apt-get install -y wget curl tar gnupg2 software-properties-common

              ########################################
              # Install Prometheus
              ########################################
              PROM_VERSION="2.54.0"
              cd /opt
              useradd --no-create-home --shell /bin/false prometheus || true
              mkdir -p /etc/prometheus /var/lib/prometheus

              wget https://github.com/prometheus/prometheus/releases/download/v$$PROM_VERSION/prometheus-$$PROM_VERSION.linux-amd64.tar.gz
              tar -xvf prometheus-$$PROM_VERSION.linux-amd64.tar.gz
              cd prometheus-$$PROM_VERSION.linux-amd64

              cp prometheus /usr/local/bin/
              cp promtool /usr/local/bin/
              cp -r consoles /etc/prometheus
              cp -r console_libraries /etc/prometheus
              cp prometheus.yml /etc/prometheus/

              chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
              chown prometheus:prometheus /usr/local/bin/prometheus /usr/local/bin/promtool

              # Create systemd service for Prometheus
              cat <<EOT > /etc/systemd/system/prometheus.service
              [Unit]
              Description=Prometheus Monitoring
              Wants=network-online.target
              After=network-online.target

              [Service]
              User=prometheus
              Group=prometheus
              Type=simple
              ExecStart=/usr/local/bin/prometheus \\
                --config.file=/etc/prometheus/prometheus.yml \\
                --storage.tsdb.path=/var/lib/prometheus/ \\
                --web.listen-address=0.0.0.0:9090 \\
                --web.enable-lifecycle

              [Install]
              WantedBy=multi-user.target
              EOT

              systemctl daemon-reload
              systemctl enable prometheus
              systemctl start prometheus

              ########################################
              # Install Grafana
              ########################################
              apt-get install -y apt-transport-https
              mkdir -p /etc/apt/keyrings/
              wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor -o /etc/apt/keyrings/grafana.gpg

              echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" > /etc/apt/sources.list.d/grafana.list

              apt-get update -y
              apt-get install -y grafana

              systemctl enable grafana-server
              systemctl start grafana-server
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
