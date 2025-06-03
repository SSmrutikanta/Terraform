provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "demo_keypair" {
  key_name = "aws_login"
  public_key = file("C:/Users/ssmru/.ssh/id_rsa.pub")

}

variable "cidr" {
  description = "cidr value"
  default = "10.0.0.0/16"
}

resource "aws_vpc" "demo_terraform" {
  cidr_block = var.cidr
}

resource "aws_subnet" "demo_subnet1" {
  vpc_id = aws_vpc.demo_terraform.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "demo_internetgateway" {
  vpc_id = aws_vpc.demo_terraform.id
  
}

resource "aws_route_table" "demo_rt" {
  vpc_id = aws_vpc.demo_terraform.id
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_internetgateway.id
  }
}
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.demo_subnet1.id
  route_table_id = aws_route_table.demo_rt.id
}

resource "aws_security_group" "webSg" {
  name   = "web"
  vpc_id = aws_vpc.demo_terraform.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
}


resource "aws_instance" "server" {
  ami                    = "ami-0e35ddab05955cf57"
  instance_type          = "t2.micro"
  key_name      = aws_key_pair.demo_keypair.key_name
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.demo_subnet1.id

  connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    private_key = file("C:/Users/ssmru/.ssh/id_rsa")  # Replace with the path to your private key
    host        = self.public_ip
  }

  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "app.py"  # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip",  # Example package installation
      "cd /home/ubuntu",
      "sudo apt install python3-flask",
      "sudo python3 app.py &",
    ]
  }
}
