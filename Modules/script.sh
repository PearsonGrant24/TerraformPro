#!/bin/bash

# Update system
sudo apt update -y
sudo apt upgrade -y

# Create Prometheus user (for security)
sudo useradd --no-create-home --shell /bin/false prometheus

# Create directories
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

# Set permissions
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

# Download Prometheus (latest stable)
cd /tmp
PROM_VERSION="2.54.0"   # <-- latest as of now
wget https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz

# Extract files
tar xvf prometheus-${PROM_VERSION}.linux-amd64.tar.gz
cd prometheus-${PROM_VERSION}.linux-amd64

# Move binaries
sudo cp prometheus /usr/local/bin/
sudo cp promtool /usr/local/bin/

# Set permissions
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool

# Move config files
sudo cp -r consoles /etc/prometheus
sudo cp -r console_libraries /etc/prometheus
sudo cp prometheus.yml /etc/prometheus

# Set permissions
sudo chown -R prometheus:prometheus /etc/prometheus
