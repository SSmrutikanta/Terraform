#!/bin/bash
# Update and install Apache
apt update -y
apt install -y apache2

# Create a simple HTML page
cat <<EOF > /var/www/html/index.html
<html>
  <head><title>Welcome</title></head>
  <body>
    <h1>Hello from EC2!</h1>
    <p>This server was provisioned using Terraform and user_data1.</p>
  </body>
</html>
EOF

# Start Apache and enable it on boot
systemctl start apache2
systemctl enable apache2
