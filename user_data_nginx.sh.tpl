#!/bin/bash
sudo su
yum -y update
amazon-linux-extras install nginx1
yum -y install httpd-tools
yum -y install git
cd /
git clone https://github.com/Cimbel/nginx.git
mkdir /etc/nginx/login
mkdir /etc/nginx/login/admin
cd /etc/nginx
htpasswd -bc .htpasswd admin admin123
echo "Adminka right here =)" > /etc/nginx/login/admin/index.html
echo "Home page" > /etc/nginx/login/index.html
cat << EOF > /nginx/nginx_part_two.conf
    server ${web_server_ip_1}:80;
    server ${web_server_ip_2}:80;
EOF
cat /nginx/nginx_part_one.conf /nginx/nginx_part_two.conf /nginx/nginx_part_three.conf > /etc/nginx/nginx.conf
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl restart nginx

