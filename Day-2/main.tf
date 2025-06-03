provider "aws" {
    region = "ap-south-1"
    alias = "region1"
  
}

provider "aws" {
    region = "ap-southeast-1"
    alias = "region2"
}

resource "aws_instance" "devops1" {
   ami = "ami-0e35ddab05955cf57"
   instance_type = "t2.micro"
   provider = aws.region1
}

resource "aws_instance" "devops2" {
   ami = "ami-01938df366ac2d954"
   instance_type = "t2.micro"
   provider = aws.region2
}