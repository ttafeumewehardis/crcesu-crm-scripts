#!/bin/bash
# Script de définition des paramètres pour l'environnement de RECETTE [CRCESU]

##################### Pré-requis #####################
# Remplir les variables avec les bonnes valeurs
#####################################################

# Informations serveur
export SERVER_NAME="hgpvnxappdlv003"

# SSL
export SSL_CHAIN_FILE="/etc/ssl/cesu-certs/cr-cesu.chain"
export SSL_KEY_FILE="/etc/ssl/cesu-certs/cr-cesu.key"
export SSL_ENABLED=0

# BDD
export BDD_HOST="HGPVNXDB2PWV002"
export BDD_PORT=50000
export BDD_NAME="DEVCESUS"
export BDD_SCHEMA="CRT"
export BDD_USER="tplanif"
export BDD_PASSWORD="tpl@nif123"

# Elastic Search
### /!\ Non utilisé pour le moment
export ES_HOST=
export ES_PORT=
export ES_NAME=

# LogStash
export LOGSTASH_ENABLED="false"
export LOGSTASH_HOST="localhost"
export LOGSTASH_PORT=5000
export LOGSTASH_SIZE=512

# CRCESU Password
export CRCESU_PASSWORD_ENDPOINT="http://srv-ms-dev01:8090/api/PasswordOublie/EnvoiCourrierOrEmailAsync"
export CRCESU_PASSWORD_TIMEOUT=
export CRCESU_PASSWORD_HEADER_API="EBTK6psJCjddGsyJtU3A"

# Mount Point
export FILE_MOUNT_POINT="\${user.dir}/crcesu/upload"
export UPLOAD_MOUNT_POINT="\${user.dir}/crcesu/mount"