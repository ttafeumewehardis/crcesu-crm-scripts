#!/bin/bash
# Script d'initialisation du front pour héberger le site CRCESU CRM

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit root
#####################################################

# Page de maintenance
cp -r $SCRIPT_PATH/releases/maintenance /opt/crcesu/crm/ >> /dev/null

# Initialisation des répertoires
chown -R crcesu-crm:crcesu-crm /opt/crcesu/crm >> /dev/null

