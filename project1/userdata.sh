#! /bin/bash
#Install docker 
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo systemctl enable --now docker

#Create zabbix external data folders for container volumes
sudo mkdir /zabbix-data
sudo mkdir /zabbix-data/alertscripts
sudo mkdir /zabbix-data/externalscripts
sudo mkdir /zabbix-data/export
sudo mkdir /zabbix-data/modules
sudo mkdir /zabbix-data/enc
sudo mkdir /zabbix-data/ssh_keys
sudo mkdir /zabbix-data/mibs
sudo mkdir /zabbix-data/snmptraps
sudo mkdir -p /zabbix-apache/apache2
sudo mkdir /zabbix-apache/modules
sudo mkdir /zabbix-mysql
sudo mkdir -p /zabbix-agent/etc/zabbix/zabbix_agentd.d
sudo mkdir -p /zabbix-agent/var/lib/zabbix/modules
sudo mkdir /zabbix-agent/var/lib/zabbix/enc
sudo mkdir /zabbix-agent/var/lib/zabbix/ssh_keys

#Add ACLs to zabbix data folders 
sudo chmod 777 -R /zabbix-data/
sudo chmod 777 -R /zabbix-nginx/
sudo chmod 777 /zabbix-mysql/
#Install docker compose
sudo apt update
sudo apt install -y curl wget
curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url  | grep docker-compose-linux-x86_64 | cut -d '"' -f 4 | wget -qi -
chmod +x docker-compose-linux-x86_64
sudo mv docker-compose-linux-x86_64 /usr/local/bin/docker-compose
#Get predefined docker compose YAML file from my repo 
wget https://raw.githubusercontent.com/arthurk3172/terraform-lab/main/project1/docker-compose.yaml
# Run containers via docker-compose 
sudo docker-compose up -d
#Open ports on firewall 
sudo ufw allow 80/tcp
sudo ufw allo 443/tcp
sudo ufw allow 10051/tcp
