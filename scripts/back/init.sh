#!/bin/bash
# Script d'initialisation du back pour héberger le site CRCESU CRM

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit d'utiliser sudo
#####################################################

# Création de l'utilisateur
sudo useradd -s /usr/sbin/nologin crcesu-crm

# Préparation des répertoires
sudo mkdir -p /opt/crcesu/crm/rollback
sudo mkdir -p /opt/crcesu/crm/archive
sudo chown -R crcesu-crm:crcesu-crm /opt/crcesu/crm
sudo mkdir -p /var/log/crcesu/crm
sudo chown crcesu-crm:crcesu-crm /var/log/crcesu/crm