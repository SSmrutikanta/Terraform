terraform {
  backend "s3" {
    bucket = "devops-example-123"
    key = "devops/tfstate"
    region = "ap-south-1"
  }
}