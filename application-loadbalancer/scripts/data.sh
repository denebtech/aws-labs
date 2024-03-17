#!/bin/bash

sudo yum update -y
sudo yum install httpd -y

sudo systemctl enable httpd
sudo systemctl start httpd

instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

echo "<html>
<head>
    <title>Hello, World!</title>
</head>
<body>
    <h1>Hello, World!</h1>
    <p>This is a simple example of a web page served by Apache on an EC2 instance.</p>
    <p>Instance ID: $instance_id</p>
</body>
</html>" | sudo tee /var/www/html/index.html
