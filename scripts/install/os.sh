#!/bin/bash
# Script d'initialisation de la machine pour héberger le site CRCESU CRM

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit root
#####################################################

# Installation de JAVA
apt-get update >> /dev/null
apt-get install -y openjdk-8-jdk >> /dev/null

# Ajout de JAVA_HOME en variable d'environment
line=$(grep "JAVA_HOME" /etc/environment)
if [ $? -eq 1 ]
    then
    echo "JAVA_HOME=\"/usr/lib/jvm/java-1.8.0-openjdk-amd64\"" >> /etc/environment
    export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64"
fi

# Installation unzip
apt-get install -y unzip >> /dev/null