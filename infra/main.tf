terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.25.0"
    }
  }
}

provider "aws" {
  region = var.regiao_aws
}



resource "aws_key_pair" "ChaveSSH" {
  key_name   = var.chave-ssh
  public_key = file("${var.chave-ssh}.pub")
}

resource "aws_instance" "vm" {
  ami             = var.ami-code
  instance_type   = var.instancia
  key_name        = aws_key_pair.ChaveSSH.key_name
  security_groups = [aws_security_group.security_group_mine.name]
  # user_data = filebase64(var.ansible-script)
}


output "ip_maquina" {
  value = aws_instance.vm.public_ip
}