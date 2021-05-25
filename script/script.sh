#!/bin/bash
#Package Installation
sudo yum -y install epel-release
sudo yum install nginx npm git -y


#Selinux Configuration
sudo sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
sudo setenforce 0

#NODEJS Configuration
sudo mkdir -p  /var/www/myapp
cd  /var/www/myapp
sudo git clone https://github.com/rvadisala/myapp.git .

sudo bash -c 'cat <<EOF > /etc/systemd/system/hello.service
[Unit]
Description=HTTP Hello World
After=network.target

[Service]
Type=simple
User=root
Group=root
Environment=PATH=/usr/bin:/usr/local/bin
Environment=NODE_ENV=production
ExecStart=/usr/bin/node /var/www/myapp/hello.js
Restart=on-failure

[Install]
WantedBy=multi-user.target

EOF'

sudo systemctl daemon-reload
sudo systemctl enable hello
sudo systemctl start hello

#Nginx Service
sudo mv /var/www/myapp/nginx.conf /etc/nginx/nginx.conf
sudo systemctl enable --now nginx
sudo systemctl restart nginx
sudo bash -c "echo 'NGINX WORKS... ;) ' > /usr/share/nginx/html/index.html"
