provider "aws" {
  region = "ap-south-1"
}

provider "vault" {
  address = "http://3.110.189.152:8200/"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "0dc37053-7651-2dc0-009f-de29ec0ade06"
      secret_id = "a3080a30-363f-5798-7f41-2fde6683cf28"
    }
  }
}
data "vault_kv_secret_v2" "example" {
  mount = "kv" // change it according to your mount
  name  = "Test-secret" // change it according to your secret
}

resource "aws_instance" "devops" {
    ami = "ami-0e35ddab05955cf57"
    instance_type = "t2.micro"
  
  tags = {
    secret = data.vault_kv_secret_v2.example.data["username"]
  }
}
