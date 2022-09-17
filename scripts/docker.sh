#!/bin/bash
echo '========================================================'
echo '=== PASO 1: INSTALACIÓN DE PREREQUISITOS PARA DOCKER ==='
echo '========================================================'
sudo apt-get update
sudo apt-get install \
apt-transport-https \
ca-certificates \
curl \
unzip \
gnupg-agent \
software-properties-common -y
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88



echo '=============================================================='
echo '=== PASO 2: AGREGAR REPOSITORIO PARA LA INSTALACIÓN DOCKER ==='
echo '=============================================================='
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
sudo apt-get update



echo '====================================='
echo '=== PASO 3: INSTALACIÓN DE DOCKER ==='
echo '====================================='
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
# Iniciar Docker junto con el Arranque del Sistema Operativo
sudo systemctl enable docker
# Agregar Usuario Actual al Grupo de Docker
sudo usermod -aG docker "$(whoami)"



echo '============================================='
echo '=== PASO 4: INSTALACIÓN DE DOCKER-COMPOSE ==='
echo '============================================='
sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose



echo '==============================================================='
echo '=== PASO 5: INICIAR DOCKER AL ARRANCAR EL SISTEMA OPERATIVO ==='
echo '==============================================================='
sudo systemctl enable docker



echo '========================================================='
echo '=== PASO 6: AGREGAR USUARIO ACTUAL AL GRUPO DE DOCKER ==='
echo '========================================================='
sudo usermod -aG docker ubuntu



echo '========================================='
echo '=== PASO 7: INSTALAR HERRAMIENTA CTOP ==='
echo '========================================='
echo "deb http://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
sudo apt update
sudo apt install docker-ctop


echo '============================================'
echo '=== PASO 8: Crear Directorio de Volumens ==='
echo '============================================'
sudo mkdir -p /storage/volumes/nginx
sudo mkdir -p /storage/volumes/apache
sudo mkdir -p /storage/volumes/nginx/certs
sudo mkdir -p /storage/volumes/nginx/vhostd
sudo mkdir -p /storage/volumes/nginx/config
sudo mkdir -p /storage/volumes/nginx/html


echo '==================================================='
echo '=== PASO 9: Clonar Repositorio de contenedores ==='
echo '==================================================='
cd /storage/volumes/nginx
sudo git clone https://github.com/microsoft/project-html-website.git
sudo mv project-html-website portal
cd /storage/volumes/nginx
sudo git clone https://github.com/microsoft/project-html-website.git
sudo mv project-html-website factura
cd /storage/volumes/apache
sudo git clone https://github.com/StartBootstrap/startbootstrap-sb-admin-2.git
sudo mv startbootstrap-sb-admin-2 erp


echo '========================================='
echo '=== PASO 10: INSTALAR HERRAMIENTA CTOP ==='
echo '========================================='
cd /storage/volumes
sudo git clone https://github.com/jcalmonaci/deploy.git  #Descargar el Archivo Docker Compose a Instancia de AWS
#cd /storage/volumes/deploy
#docker-compose up -d
#sudo cp /storage/volumes/deploy/nginx/settings.config /storage/volumes/nginx/config
docker-compose -f deploy/docker-compose.yml up -d             #Ejecutar Archivo Docker Compose para creación de contenedores