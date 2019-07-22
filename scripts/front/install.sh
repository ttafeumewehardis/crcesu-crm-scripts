#!/bin/bash
# Script d'installation du front pour héberger le site CRCESU CRM

# Params : 
# $1 : version

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit d'utiliser sudo
#####################################################

# Get WAR
sudo wget https://hardis-crcesu-releases.s3.eu-west-3.amazonaws.com/$1/crm-ihm-app-$1.zip

# Installation
sudo cp crm-ihm-app-$1.zip /opt/crcesu/crm
sudo mkdir -p /opt/crcesu/crm/crm-ihm-app-$1
sudo unzip -o /opt/crcesu/crm/crm-ihm-app-$1.zip -d /opt/crcesu/crm/crm-ihm-app-$1/
sudo ln -s /opt/crcesu/crm/crm-ihm-app-$1 /opt/crcesu/crm/crm-ihm-app
sudo chown crcesu-crm:crcesu-crm /opt/crcesu/crm/crm-ihm-app
sudo rm -fr crm-ihm-app-$1.zip

# Clean
sudo rm -fr crm-ihm-app-$1.zip