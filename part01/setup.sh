#!/bin/bash

# Mise à jour du système
echo "Mise à jour du système..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Installation de Docker
echo "Installation de Docker..."
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Ajout de l'utilisateur au groupe Docker
echo "Ajout de l'utilisateur au groupe Docker..."
sudo usermod -aG docker $USER

# Installation des dépendances GNS3
echo "Installation des dépendances GNS3..."
sudo apt-get install -y python3-pip python3-dev libffi-dev libssl-dev libpcap-dev

# Installation du serveur GNS3
echo "Installation du serveur GNS3..."
sudo pip3 install gns3-server

# Installation du client GNS3 GUI
echo "Installation du client GNS3 GUI..."
sudo pip3 install gns3-gui

# Ajout de l'utilisateur au groupe ubridge
echo "Configuration des permissions GNS3..."
sudo usermod -aG ubridge $USER
sudo usermod -aG kvm $USER
sudo usermod -aG wireshark $USER

# Redémarrage nécessaire pour appliquer les changements de groupe
echo "L'installation est terminée. Veuillez redémarrer votre ordinateur pour appliquer les changements."
