provider "aws" {
  region = "ap-south-1"
}

variable "ami_value" {
  description = "This is the ami avlue"
}

variable "instance_type_value" {
  description = "instance_type_value"
  type =  map(string)

  default = {
    dev = "t2.medium"
    sit = "t2.micro"
    prod = "t2.micro"
  }
}

module "name" {
  source = "./modules/ec2_instance"
  ami_value = var.ami_value
  instance_type_value = lookup(var.instance_type_value, terraform.workspace, "t2.micro")
}