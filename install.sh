#!/bin/bash
# Script d'installation d'un environment complet

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
source $SCRIPT_PATH/releases/$2.sh

# Permissions
sudo chmod -R +x $SCRIPT_PATH/scripts

# Préparation de l'OS
sh $SCRIPT_PATH/scripts/install/os.sh

# Installation de NGinx
sh $SCRIPT_PATH/scripts/install/nginx.sh 0

# Installation du back
sh $SCRIPT_PATH/scripts/back/init.sh
sh $SCRIPT_PATH/scripts/back/install.sh $2

# Installation du front
sh $SCRIPT_PATH/scripts/front/init.sh
sh $SCRIPT_PATH/scripts/front/install.sh $2

# Redémarrage de NGinx
sudo nginx -s reload
