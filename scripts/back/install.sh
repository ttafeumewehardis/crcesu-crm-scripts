#!/bin/bash
# Script d'installation du back pour héberger le site CRCESU CRM

# Params : 
# $1 : version

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit d'utiliser sudo
#####################################################

# Installation
sudo cp $SCRIPT_PATH/releases/$1/crm-api-app-$1.war /opt/crcesu/crm
sudo ln -s /opt/crcesu/crm/crm-api-app-$1.war /opt/crcesu/crm/crm-api-app.war
sudo chown crcesu-crm:crcesu-crm /opt/crcesu/crm/*.war

# Extraction du fichier template de configuration
jar xvf $SCRIPT_PATH/releases/$1/crm-api-app-$1.war WEB-INF/classes/config/application-template.yml
sudo mv WEB-INF/classes/config/application-template.yml /opt/crcesu/crm/crm-api.yml
rm -fr WEB-INF

# Remplacement des paramètres
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - spring.datasource.url "jdbc:db2://$BDD_HOST:$BDD_PORT/$BDD_NAME" | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - spring.datasource.username "$BDD_USER" | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - spring.datasource.password "$BDD_PASSWORD" | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - spring.datasource.hikari.data-source-properties.currentSchema "$BDD_SCHEMA" | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - jhipster.logging.logstash.enabled "$LOGSTASH_ENABLED" | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - jhipster.logging.logstash.host "$LOGSTASH_HOST" | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - jhipster.logging.logstash.port "$LOGSTASH_PORT" | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - jhipster.logging.logstash.queue-size "$LOGSTASH_SIZE" | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - application.service.ws.endpoint "$CRCESU_PASSWORD_ENDPOINT" | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml
sudo cat /opt/crcesu/crm/crm-api.yml | yq w - application.service.ws.timeout "$CRCESU_PASSWORD_TIMEOUT" | sudo tee /opt/crcesu/crm/crm-api.yml.tmp && sudo mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml
sudo chown -R crcesu-crm:crcesu-crm /opt/crcesu/crm

# Création du service
sudo cp $SCRIPT_PATH/templates/back/crm-api.service /etc/systemd/system/crm-api.service

# Démarrage
sudo systemctl enable crm-api.service
sudo systemctl start crm-api.service