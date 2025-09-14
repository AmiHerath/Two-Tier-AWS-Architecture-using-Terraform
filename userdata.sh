#!/bin/bash
# install httpd 
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello World from new Web </h1>" > /var/www/html/index.html
