module "Mine-craft" {
  source         = "../infra"
  regiao_aws     = "us-east-2"
  chave-ssh      = "ssh_mine"
  ami-code       = "ami-0e83be366243f524a"
  instancia      = "t2.micro"
  ansible-script = "./ansible.sh"
}

output "ip" {
  value = module.Mine-craft.ip_maquina
}