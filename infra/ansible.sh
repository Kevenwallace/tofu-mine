#!/bin/bash
cd /home/ubuntu
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py

sudo python3 -m pip install ansible
tee -a playbook.yml > /dev/null << EOT
---
- hosts: localhost
  tasks:
    - name: Instalando python3
      apt:
        pkg:
        - python3
        update_cache: yes
      become: yes

    - name: Baixar Aquivo JDK
      get_url:
        url: "https://download.oracle.com/java/17/latest/jdk-17_linux-aarch64_bin.tar.gz"
        dest: "/home/mine/jdk-17_linux-aarch64_bin.tar.gz"
    - name: Extrair arquivo JDK
        src:  "/home/mine/jdk-17_linux-aarch64_bin.tar.gz"
        dest: "/opt"
    - name: Baixar Mine-Serv
      get_url:
        url: "https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar"
        dest: "/home/mine/serv/minecraft_server.jar"
    - name: Executar Mine-Serv
      command: echo 'eula=true' > /home/mine/serv/eula.txt
      command: "/opt/jdk-17.0.9/bin/java -Xmx1024M -Xms1024M -jar /home/mine/serv/minecraft_server.jar nogui"

EOT
ansible-playbook playbook.yml