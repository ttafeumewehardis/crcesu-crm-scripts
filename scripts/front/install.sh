#!/bin/bash
# Script d'installation du front pour héberger le site CRCESU CRM

# Params : 
# $1 : version

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit d'utiliser sudo
#####################################################

# Get WAR
sudo wget $LINK_FRONT

# Installation
sudo cp crm-ihm-app-$1.tar.gz2 /opt/crcesu/crm
sudo mkdir -p /opt/crcesu/crm/crm-ihm-app-$1
sudo tar -xjvf /opt/crcesu/crm/crm-ihm-app-$1.tar.gz2 -C /opt/crcesu/crm/crm-ihm-app-$1/
sudo ln -s /opt/crcesu/crm/crm-ihm-app-$1 /opt/crcesu/crm/crm-ihm-app
sudo chown crcesu-crm:crcesu-crm /opt/crcesu/crm/crm-ihm-app

# Clean
sudo rm -fr crm-ihm-app-$1.tar.gz2