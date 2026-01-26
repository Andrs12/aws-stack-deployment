#!/bin/bash
set -e

# Update system
dnf update -y

# Install dependencies
dnf install -y \
  docker \
  git \
  wget \
  curl \
  amazon-cloudwatch-agent

# Start Docker
systemctl enable docker
systemctl start docker

# Add ec2-user to docker group
usermod -aG docker ec2-user

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create app directory
mkdir -p /opt/app
chown ec2-user:ec2-user /opt/app

# Configure CloudWatch Agent (basic)
cat > /opt/aws/amazon-cloudwatch-agent/etc/config.json << 'CWCONFIG'
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/messages",
            "log_group_name": "/aws/ec2/${environment}",
            "log_stream_name": "{instance_id}/messages"
          }
        ]
      }
    }
  }
}
CWCONFIG

# Start CloudWatch Agent
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -s \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/config.json

# Create simple health check endpoint
cat > /var/www/html/health << 'HEALTH'
OK
HEALTH

# Install and configure nginx
dnf install -y nginx
systemctl enable nginx
systemctl start nginx

echo "Bootstrap complete - Environment: ${environment}"
