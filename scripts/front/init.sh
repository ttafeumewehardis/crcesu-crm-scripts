#!/bin/bash
# Script d'initialisation du front pour héberger le site CRCESU CRM

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit d'utiliser sudo
#####################################################

# Page de maintenance
sudo cp -r $SCRIPT_PATH/releases/maintenance /opt/crcesu/crm/

# Initialisation des répertoires
sudo chown -R crcesu-crm:crcesu-crm /opt/crcesu/crm

