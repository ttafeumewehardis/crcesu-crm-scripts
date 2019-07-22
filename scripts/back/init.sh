#!/bin/bash
# Script d'initialisation du back pour héberger le site CRCESU CRM

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit d'utiliser sudo
#####################################################

# Création de l'utilisateur
sudo useradd -s /usr/sbin/nologin crcesu-crm >> /dev/null

# Préparation des répertoires
sudo mkdir -p /opt/crcesu/crm/rollback >> /dev/null
sudo mkdir -p /opt/crcesu/crm/archive >> /dev/null
sudo chown -R crcesu-crm:crcesu-crm /opt/crcesu/crm >> /dev/null
sudo mkdir -p /var/log/crcesu/crm >> /dev/null
sudo chown crcesu-crm:crcesu-crm /var/log/crcesu/crm >> /dev/null