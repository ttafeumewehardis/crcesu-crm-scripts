#!/bin/bash
# Script d'initialisation de la machine pour héberger le site CRCESU CRM

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit d'utiliser sudo
#####################################################

# Installation de JAVA
sudo apt-get update >> /dev/null
sudo apt-get install -y openjdk-8-jdk >> /dev/null

# Ajout de JAVA_HOME en variable d'environment
line=$(grep "JAVA_HOME" /etc/environment)
if [ $? -eq 1 ]
    then
    sudo echo "JAVA_HOME=\"/usr/lib/jvm/java-1.8.0-openjdk-amd64\"" >> /etc/environment
    export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64"
fi

# Installation de YAML commond line tool
sudo add-apt-repository ppa:rmescandon/yq -y -u >> /dev/null
sudo apt-get install yq -y >> /dev/null

# Installation unzip
sudo apt-get install -y unzip >> /dev/null