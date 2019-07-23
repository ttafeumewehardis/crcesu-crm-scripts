#!/bin/bash
# Script d'installation du front pour héberger le site CRCESU CRM

# Params : 
# $1 : version

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit root
#####################################################

# Get WAR
wget -q https://hardis-crcesu-releases.s3.eu-west-3.amazonaws.com/$1/crm-ihm-app-$1.zip >> /dev/null

# Installation
cp crm-ihm-app-$1.zip /opt/crcesu/crm >> /dev/null
mkdir -p /opt/crcesu/crm/crm-ihm-app-$1 >> /dev/null
unzip -o /opt/crcesu/crm/crm-ihm-app-$1.zip -d /opt/crcesu/crm/crm-ihm-app-$1/ >> /dev/null
ln -s /opt/crcesu/crm/crm-ihm-app-$1 /opt/crcesu/crm/crm-ihm-app >> /dev/null
chown crcesu-crm:crcesu-crm /opt/crcesu/crm/crm-ihm-app >> /dev/null

# Clean
rm -fr crm-ihm-app-$1.zip >> /dev/null