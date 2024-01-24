IAC simples para provisionamento de um servidor de minecraft na aws

passos:
na pasta do modulo(mine)
1-"tofu init"
2-"ssh-keygen -f ./ssh_mine"
3-"tofu plan -out=plano
4-"tofu apply "plano""
obs: voce deve esta logado com o seu aws cli na maquina ou com as chaves exportadas corretamente



Usando uma instancia t2.micro precisamos rodar o ansible por ssh com o playbooks e o host usando o comando:
ansible-playbook playbooks.yml -u ubuntu --private-key "sua_chave_ssh" -i hosts.yml
OBS:MODIFICAR O IP DE HOSTS PARA O IP DA MAQUINA QUE SERA APLICADO


Usando uma instancia com mais recursos o ansible pode ser rodado direto na maquina, basta retirar o comentario de "user_data" no main.tf da pasta infra

A memoria usada pela JVM tambem pode ser modificada nos scrips no momento de rodar o Serv, para poupar recurso estou rodando apenas 512m "-Xmx512M -Xms512M"



