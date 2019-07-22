#!/bin/bash
# Script d'installation du back pour héberger le site CRCESU CRM

# Params : 
# $1 : version

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit d'utiliser sudo
#####################################################

# Get WAR
sudo wget -q https://hardis-crcesu-releases.s3.eu-west-3.amazonaws.com/$1/crm-api-app-$1.war >> /dev/null

# Installation
sudo cp crm-api-app-$1.war /opt/crcesu/crm >> /dev/null
sudo ln -s /opt/crcesu/crm/crm-api-app-$1.war /opt/crcesu/crm/crm-api-app.war >> /dev/null
sudo chown crcesu-crm:crcesu-crm /opt/crcesu/crm/*.war >> /dev/null

# Extraction du fichier template de configuration
jar xvf crm-api-app-$1.war WEB-INF/classes/config/application-template.yml >> /dev/null
sudo mv WEB-INF/classes/config/application-template.yml /opt/crcesu/crm/crm-api.yml >> /dev/null
sudo rm -fr WEB-INF >> /dev/null
sudo rm -fr crm-api-app-$1.war >> /dev/null

# Remplacement des paramètres
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - spring.datasource.url "jdbc:db2://$BDD_HOST:$BDD_PORT/$BDD_NAME" | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
if [ ! -z "$BDD_USER" ]
then
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - spring.datasource.username $BDD_USER | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$BDD_PASSWORD" ]
then
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - spring.datasource.password $BDD_PASSWORD | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$BDD_SCHEMA" ]
then
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - spring.datasource.hikari.data-source-properties.currentSchema $BDD_SCHEMA | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$LOGSTASH_ENABLED" ]
then
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - jhipster.logging.logstash.enabled $LOGSTASH_ENABLED | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$LOGSTASH_HOST" ]
then
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - jhipster.logging.logstash.host $LOGSTASH_HOST | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$LOGSTASH_PORT" ]
then
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - jhipster.logging.logstash.port $LOGSTASH_PORT | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$LOGSTASH_SIZE" ]
then
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - jhipster.logging.logstash.queue-size $LOGSTASH_SIZE | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$CRCESU_PASSWORD_ENDPOINT" ]
then
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - application.service.ws.endpoint $CRCESU_PASSWORD_ENDPOINT | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$CRCESU_PASSWORD_TIMEOUT" ]
then
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - application.service.ws.timeout $CRCESU_PASSWORD_TIMEOUT | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$CRCESU_PASSWORD_HEADER_API" ]
then
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - application.service.ws.header.x-apikey $CRCESU_PASSWORD_HEADER_API | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
cp /opt/crcesu/crm/crm-api.yml /opt/crcesu/crm/crm-api-$1.yml >> /dev/null
sudo chown -R crcesu-crm:crcesu-crm /opt/crcesu/crm >> /dev/null

# Création du service
sudo cp $SCRIPT_PATH/templates/back/crm-api.service /etc/systemd/system/crm-api.service >> /dev/null

# Démarrage
sudo systemctl enable crm-api.service >> /dev/null
sudo systemctl start crm-api.service >> /dev/null

# Clean
sudo rm -fr crm-api-app-$1.war >> /dev/null