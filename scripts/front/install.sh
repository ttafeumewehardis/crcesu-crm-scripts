#!/bin/bash
# Script d'installation du front pour héberger le site CRCESU CRM

# Params : 
# $1 : version

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit d'utiliser sudo
#####################################################

# Mise en maintenance
sudo -u crcesu-crm touch /opt/crcesu/crm/maintenance/crm_ihm.lock

# Installation
sudo cp $SCRIPT_PATH/releases/$1/crm-ihm-app-$1.tar.gz2 /opt/crcesu/crm
sudo mkdir -p /opt/crcesu/crm/crm-ihm-app-$1
sudo tar -xjvf /opt/crcesu/crm/crm-ihm-app-$1.tar.gz2 -C /opt/crcesu/crm/crm-ihm-app-$1/
sudo ln -s /opt/crcesu/crm/crm-ihm-app-$1 /opt/crcesu/crm/crm-ihm-app
sudo chown crcesu-crm:crcesu-crm /opt/crcesu/crm/crm-ihm-app

# Suppression maintenance
sudo rm /opt/crcesu/crm/maintenance/crm_ihm.lock

# Redémarrage de NGinx
sudo nginx -s reload