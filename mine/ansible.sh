#!/bin/bash
cd /home/ubuntu
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py

sudo python3 -m pip install ansible
tee -a playbook.yml > /dev/null << EOT
- hosts: localhost
  tasks:
    - name: Instalando python3
      apt:
        pkg:
        - python3
        update_cache: yes
      become: yes
    - name: Criar diretório /home/mine
      file:
        path: /home/ubuntu/mine
        state: directory
        mode: '0777'
      become: yes
      file:
        path: /home/ubuntu/mine/serv
        state: directory
        mode: '0777'
      become: yes
    - name: Baixar Aquivo JDK
      get_url:
        url: https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz
        dest: /home/ubuntu/mine/jdk-21_linux-aarch64_bin.tar.gz
        mode: '0644'
        owner: ubuntu
        group: ubuntu
    - name: Extrair arquivo JDK
      ansible.builtin.unarchive:
        src:  /home/ubuntu/mine/jdk-21_linux-aarch64_bin.tar.gz
        dest: /opt
        remote_src: yes
      become: yes
    - name: Baixar Mine-Serv
      get_url:
        url: https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar
        dest: /home/ubuntu/mine/serv/minecraft_server.jar
    - name: Executar Mine-Serv
      ansible.builtin.shell:
        cmd: |
          echo 'eula=true' > /home/ubuntu/mine/serv/eula.txt
          echo '#Minecraft server properties
                #Mon Jan 22 13:44:38 BRT 2024
                allow-flight=false
                allow-nether=false
                broadcast-console-to-ops=true
                broadcast-rcon-to-ops=true
                difficulty=easy
                enable-command-block=false
                enable-jmx-monitoring=false
                enable-query=false
                enable-rcon=false
                enable-status=true
                enforce-secure-profile=true
                enforce-whitelist=false
                entity-broadcast-range-percentage=100
                force-gamemode=false
                function-permission-level=2
                gamemode=survival
                generate-structures=true
                generator-settings={}
                hardcore=false
                hide-online-players=false
                initial-disabled-packs=
                initial-enabled-packs=vanilla
                level-name=world
                level-seed=
                level-type=minecraft\:flat
                log-ips=true
                max-chained-neighbor-updates=1000000
                max-players=20
                max-tick-time=60000
                max-world-size=29999984
                motd=A Minecraft Server
                network-compression-threshold=256' > /home/ubuntu/mine/serv/server.properties
          echo "online-mode=true
                op-permission-level=4
                player-idle-timeout=0
                prevent-proxy-connections=false
                pvp=true
                query.port=25565
                rate-limit=0
                rcon.password=
                rcon.port=25575
                require-resource-pack=false
                resource-pack=
                resource-pack-id=
                resource-pack-prompt=
                resource-pack-sha1=
                server-ip=
                server-port=25565
                simulation-distance=10
                spawn-animals=false
                spawn-monsters=false
                spawn-npcs=true
                spawn-protection=16
                sync-chunk-writes=true
                text-filtering-config=
                use-native-transport=true
                view-distance=10
                white-list=false" >> /home/ubuntu/mine/serv/server.properties
          cd /home/ubuntu/mine/serv
          nohup /opt/jdk-21.0.2/bin/java -Xmx512M -Xms512M -jar /home/ubuntu/mine/serv/minecraft_server.jar nogui > /home/ubuntu/mine/serv/server.log 2>&1 &

EOT
ansible-playbook playbook.yml