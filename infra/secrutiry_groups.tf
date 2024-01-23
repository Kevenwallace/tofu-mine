resource "aws_security_group" "aws_security_group" {
  name        = "security-group"
  description = "grupo para logar"
  ingress {
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
  }
  egress {
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 0
    to_port          = 0      #em prod libera so a porta da api
    protocol         = "-1"   #em prod libera apenas o protoclo q usa
  }
  tags = {
    Name = "acesso_geral"
  }

}