#!/bin/bash

echo "🚀 Deploying Monitoring Stack (Prometheus + Grafana + Node Exporter)"
echo "======================================================================"

# Dizine geç
cd /home/ec2-user/flask-blog-devops-stack/monitoring

# Önceki container'ları durdur ve sil
echo "🛑 Stopping existing monitoring containers..."
sudo docker stop prometheus grafana node-exporter 2>/dev/null || true
sudo docker rm prometheus grafana node-exporter 2>/dev/null || true

# Docker Compose ile başlat
echo "📦 Starting monitoring stack with Docker Compose..."
sudo docker-compose -f docker-compose-monitoring.yml up -d

# Container durumunu kontrol et
echo "✅ Checking container status..."
sudo docker ps | grep -E "(prometheus|grafana|node-exporter)"

echo ""
echo "🎯 Access URLs:"
echo "- Prometheus: http://$(curl -s ifconfig.me):9090"
echo "- Grafana: http://$(curl -s ifconfig.me):3000 (admin/admin123)"
echo "- Node Exporter: http://$(curl -s ifconfig.me):9100"
echo ""
echo "📊 Grafana Setup:"
echo "1. Login with admin/admin123"
echo "2. Add Prometheus datasource: http://prometheus:9090"
echo "3. Import dashboard ID: 1860 (Node Exporter Full)"
echo ""
echo "✅ Monitoring stack deployment completed!" 