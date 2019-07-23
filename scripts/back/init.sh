#!/bin/bash
# Script d'initialisation du back pour héberger le site CRCESU CRM

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit root
#####################################################

# Création de l'utilisateur
useradd -s /usr/sbin/nologin crcesu-crm >> /dev/null

# Préparation des répertoires
mkdir -p /opt/crcesu/crm/rollback >> /dev/null
mkdir -p /opt/crcesu/crm/archive >> /dev/null
chown -R crcesu-crm:crcesu-crm /opt/crcesu/crm >> /dev/null
mkdir -p /var/log/crcesu/crm >> /dev/null
chown crcesu-crm:crcesu-crm /var/log/crcesu/crm >> /dev/null