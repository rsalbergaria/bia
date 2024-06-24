#!/bin/bash

# Atualizar pacotes e instalar Docker e Git
sudo yum update -y
sudo yum install git -y
sudo yum install docker -y

# Adicionar usuários ao grupo Docker
sudo usermod -a -G docker ec2-user
sudo usermod -a -G docker ssm-user
id ec2-user ssm-user
sudo newgrp docker

# Ativar e iniciar Docker
sudo systemctl enable docker.service
sudo systemctl start docker.service

# Instalar Docker Compose 2.28.0 para x86_64
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -L https://github.com/docker/compose/releases/download/v2.28.0/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Adicionar swap
sudo dd if=/dev/zero of=/swapfile bs=128M count=32
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "/swapfile swap swap defaults 0 0" | sudo tee -a /etc/fstab

# Instalar Node.js e npm
curl -fsSL https://rpm.nodesource.com/setup_21.x | sudo bash -
sudo yum install -y nodejs

# Instalar PostgreSQL Client (psql)
sudo yum install -y postgresql15.x86_64

# Verificar versões instaladas
docker --version
docker-compose --version
node --version
npm --version
psql --version
