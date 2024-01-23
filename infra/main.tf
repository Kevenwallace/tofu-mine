terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.25.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}



resource "aws_key_pair" "ChaveSSH" {
  key_name   = "ssh_mine"
  public_key = file("./ssh_mine.pub")
}

resource "aws_instance" "vm" {
  ami             = "ami-0e83be366243f524a"
  instance_type   = "t2.micro"
  key_name        = "ssh_mine"
  security_groups = [aws_security_group.aws_security_group.name]
  # user_data = filebase64("./ansible.sh")
}


