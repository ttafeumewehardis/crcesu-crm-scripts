#!/bin/bash
# Script d'installation d'un environment complet

# Params : 
# $1 : env
# $2 : version

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit root
# La base de données doit être accessible depuis le serveur
# Remplir les variables avec les bonnes valeurs
#####################################################

# Initialisation des variables d'environnements
export SCRIPT_PATH=`pwd`
source $SCRIPT_PATH/config/$1.sh

# Permissions
chmod -R +x $SCRIPT_PATH/scripts

# Préparation de l'OS
echo " ------- Installation des outils ------- "
sh $SCRIPT_PATH/scripts/install/os.sh >> /dev/null

# Installation de NGinx
echo " ------- Installation de NGinx ------- "
sh $SCRIPT_PATH/scripts/install/nginx.sh 0 >> /dev/null

# Installation du back
echo " ------- Installation du backend ------- "
sh $SCRIPT_PATH/scripts/back/init.sh >> /dev/null
sh $SCRIPT_PATH/scripts/back/install.sh $2 >> /dev/null

# Installation du front
echo " ------- Installation du front ------- "
sh $SCRIPT_PATH/scripts/front/init.sh >> /dev/null
sh $SCRIPT_PATH/scripts/front/install.sh $2 >> /dev/null

# Redémarrage de NGinx
echo " ------- Redémarrage de NGinx ------- "
nginx -s reload >> /dev/null

# Attente démarrage
echo " ------- Attente démarrage ------- "
sleep 60