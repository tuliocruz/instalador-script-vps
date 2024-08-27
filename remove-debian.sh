#!/bin/bash

# Verifica se o script já foi executado
if [ ! -f /root/.server ]; then
    echo "No setup found to revert"
    exit 0
fi

# Remove arquivos e configurações adicionados
sudo rm -f /bin/promovaweb
sudo rm -f /bin/promovaweb-updater
sudo rm -f /etc/cron.d/promovaweb-updater
sudo rm -f /root/.server
sudo rm -f /root/.token

# Remove o swap file
sudo swapoff /swapfile
sudo rm -f /swapfile

# Remove entrada do fstab
sudo sed -i '/\/swapfile none swap sw 0 0/d' /etc/fstab

# Remove repositório PHP
sudo rm -f /etc/apt/sources.list.d/sury-php.list

# Remove pacotes instalados
sudo apt-get remove --purge -y php-cli curl cron gnupg2 lsb-release ca-certificates apt-transport-https software-properties-common

# Limpa pacotes desnecessários
sudo apt-get autoremove -y
sudo apt-get clean

# Remove o Certbot, se instalado
sudo apt-get remove --purge -y certbot
sudo apt-get autoremove -y
sudo apt-get clean

# Reinicializa o sistema, se necessário
# sudo reboot

echo "Reversão Finalizada."
