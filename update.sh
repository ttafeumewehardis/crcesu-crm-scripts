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

# Update page de maintenance
echo " ------- MAJ Page de maintenance ------- "
sudo cp -r $SCRIPT_PATH/releases/maintenance /opt/crcesu/crm/ >> /dev/null

# Mise en maintenance
echo " ------- Mise en maintenance ------- "
sudo -u crcesu-crm touch /opt/crcesu/crm/maintenance/crm_ihm.lock >> /dev/null

# Arrêt des services
echo " ------- Arrêt du service ------- "
sudo systemctl stop crm-api.service >> /dev/null

# Attente arrêt
echo " ------- Attente arrêt ------- "
sleep 30

# Update de NGinx
echo " ------- MAJ NGinx ------- "
sh $SCRIPT_PATH/scripts/install/nginx.sh 1 >> /dev/null

# Suppression des liens
echo " ------- Suppression de l'application ------- "
sudo rm -fr /opt/crcesu/crm/crm-api-app.war >> /dev/null
sudo rm -fr /opt/crcesu/crm/crm-api.yml >> /dev/null
sudo rm -fr /opt/crcesu/crm/crm-ihm-app >> /dev/null

# Archivage du précédent rollback
echo " ------- Archivage ------- "
sudo cp /opt/crcesu/crm/rollback/*.war /opt/crcesu/crm/archive/ >> /dev/null
sudo cp /opt/crcesu/crm/rollback/crm-api*.yml /opt/crcesu/crm/archive/ >> /dev/null
sudo cp -r /opt/crcesu/crm/rollback/crm-ihm-app* /opt/crcesu/crm/archive/ >> /dev/null
sudo rm -fr /opt/crcesu/crm/rollback/*.war >> /dev/null
sudo rm -fr /opt/crcesu/crm/rollback/crm-api*.yml >> /dev/null
sudo rm -fr /opt/crcesu/crm/rollback/crm-ihm-app* >> /dev/null 

# Rollback
echo " ------- Rollback ------- "
sudo cp /opt/crcesu/crm/*.war /opt/crcesu/crm/rollback/ >> /dev/null
sudo cp /opt/crcesu/crm/crm-api*.yml /opt/crcesu/crm/rollback/ >> /dev/null
sudo cp -r /opt/crcesu/crm/crm-ihm-app* /opt/crcesu/crm/rollback/ >> /dev/null
sudo rm -fr /opt/crcesu/crm/*.war >> /dev/null
sudo rm -fr /opt/crcesu/crm/crm-api*.yml >> /dev/null
sudo rm -fr /opt/crcesu/crm/crm-ihm-app* >> /dev/null

# Installation du back
echo " ------- Installation du backend ------- "
sh $SCRIPT_PATH/scripts/back/install.sh $2 >> /dev/null

# Installation du front
echo " ------- Installation du frontend ------- "
sh $SCRIPT_PATH/scripts/front/install.sh $2 >> /dev/null

# Redémarrage de NGinx
echo " ------- Rechargement NGinx ------- "
sudo nginx -s reload >> /dev/null

# Attente démarrage
echo " ------- Attente démarrage ------- "
sleep 30

# Suppression maintenance
echo " ------- Remise en service ------- "
sudo rm /opt/crcesu/crm/maintenance/crm_ihm.lock >> /dev/null
