#!/bin/bash
# Script d'initialisation de la machine pour héberger le site CRCESU CRM

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit d'utiliser sudo
#####################################################

# Installation de JAVA
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk

# Ajout de JAVA_HOME en variable d'environment
sudo echo "JAVA_HOME=\"/usr/lib/jvm/java-1.8.0-openjdk-amd64\"" >> /etc/environment
export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64"

# Installation de YAML commond line tool
sudo add-apt-repository ppa:rmescandon/yq -y -u
sudo apt install yq -y