provider "aws" {
  region = "ap-south-1"
}

module "name" {
  source = "./modules/ec2_instance"
  ami_value = "ami-0e35ddab05955cf57"
  instance_type_value = "t2.micro"
}