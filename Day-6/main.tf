provider "aws" {
  region = "ap-south-1"
}

variable "ami_value" {
  description = "This is the ami avlue"
}

variable "instance_type_value" {
  description = "instance_type_value"
}

module "name" {
  source = "./modules/ec2_instance"
  ami_value = var.ami_value
  instance_type_value = var.instance_type_value
}