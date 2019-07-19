#!/bin/bash
# Script d'update d'un environment complet

# Params : 
# $1 : env
# $2 : version

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit d'utiliser sudo
# La base de données doit être accessible depuis le serveur
# Remplir les variables avec les bonnes valeurs
#####################################################

# Initialisation des variables d'environnements
export SCRIPT_PATH=`pwd`
source $SCRIPT_PATH/config/$1.sh

# Permissions
sudo chmod -R +x $SCRIPT_PATH/scripts

# Mise en maintenance
sudo -u crcesu-crm touch /opt/crcesu/crm/maintenance/crm_ihm.lock

# Arrêt des services
sudo systemctl stop crm-api.service

# Update de NGinx
sh $SCRIPT_PATH/scripts/install/nginx.sh 1

# Suppression des liens
sudo rm -fr /opt/crcesu/crm/crm-api-app.war
sudo rm -fr /opt/crcesu/crm/crm-api.yml
sudo rm -fr /opt/crcesu/crm/crm-ihm-app

# Archivage du précédent rollback
sudo cp /opt/crcesu/crm/rollback/*.war /opt/crcesu/crm/archive/
sudo cp /opt/crcesu/crm/rollback/crm-api*.yml /opt/crcesu/crm/archive/
sudo cp -r /opt/crcesu/crm/rollback/crm-ihm-app* /opt/crcesu/crm/archive/
sudo rm -fr /opt/crcesu/crm/rollback/*.war
sudo rm -fr /opt/crcesu/crm/rollback/crm-api*.yml
sudo rm -fr /opt/crcesu/crm/rollback/crm-ihm-app* 

# Rollback
sudo cp /opt/crcesu/crm/*.war /opt/crcesu/crm/rollback/
sudo cp /opt/crcesu/crm/crm-api*.yml /opt/crcesu/crm/rollback/
sudo cp -r /opt/crcesu/crm/crm-ihm-app* /opt/crcesu/crm/rollback/
sudo rm -fr /opt/crcesu/crm/*.war
sudo rm -fr /opt/crcesu/crm/crm-api*.yml
sudo rm -fr /opt/crcesu/crm/crm-ihm-app*

# Installation du back
sh $SCRIPT_PATH/scripts/back/install.sh $2

# Installation du front
sh $SCRIPT_PATH/scripts/front/install.sh $2

# Suppression maintenance
sudo rm /opt/crcesu/crm/maintenance/crm_ihm.lock

# Redémarrage de NGinx
sudo nginx -s reload