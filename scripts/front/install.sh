#!/bin/bash
# Script d'installation du front pour héberger le site CRCESU CRM

# Params : 
# $1 : version

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit d'utiliser sudo
#####################################################

# Get WAR
sudo wget -q https://hardis-crcesu-releases.s3.eu-west-3.amazonaws.com/$1/crm-ihm-app-$1.zip >> /dev/null

# Installation
sudo cp crm-ihm-app-$1.zip /opt/crcesu/crm >> /dev/null
sudo mkdir -p /opt/crcesu/crm/crm-ihm-app-$1 >> /dev/null
sudo unzip -o /opt/crcesu/crm/crm-ihm-app-$1.zip -d /opt/crcesu/crm/crm-ihm-app-$1/ >> /dev/null
sudo ln -s /opt/crcesu/crm/crm-ihm-app-$1 /opt/crcesu/crm/crm-ihm-app >> /dev/null
sudo chown crcesu-crm:crcesu-crm /opt/crcesu/crm/crm-ihm-app >> /dev/null
sudo rm -fr crm-ihm-app-$1.zip >> /dev/null

# Clean
sudo rm -fr crm-ihm-app-$1.zip >> /dev/null