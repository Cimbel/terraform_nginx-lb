#!/bin/bash
sudo yum -y update
sudo yum -y install httpd
sudo systemctl start httpd
sudo cat << EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Web-Server-2</title>
	</head>
<body>
	<p class="text">
		Welcome to NGINX!! I am a student of devops-crash-course-spring-2021. I am number <span>%20%</span> in the devops-crash-course-spring-2021
		It’s a server <span>#2</span>
	</p>
<style>
	body{
		background-color: #000;
		font-family: sans-serif;
	}
	.text{
		width: 300px;
		color: #fff;
	}
	.text span{
		color: orange;
		font-weight: 600;
	}
</style>
<body>
</html>
EOF
sudo systemctl restart httpd
sudo systemctl enable httpd
