#!/bin/bash
# Script d'installation du back pour héberger le site CRCESU CRM

# Params : 
# $1 : version

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit root
#####################################################

# Get WAR
wget -q https://hardis-crcesu-releases.s3.eu-west-3.amazonaws.com/$1/crm-api-app-$1.war >> /dev/null

# Installation
cp crm-api-app-$1.war /opt/crcesu/crm >> /dev/null
ln -s /opt/crcesu/crm/crm-api-app-$1.war /opt/crcesu/crm/crm-api-app.war >> /dev/null
chown crcesu-crm:crcesu-crm /opt/crcesu/crm/*.war >> /dev/null

# Extraction du fichier template de configuration
jar xvf crm-api-app-$1.war WEB-INF/classes/config/application-template.yml >> /dev/null
mv WEB-INF/classes/config/application-template.yml /opt/crcesu/crm/crm-api.yml >> /dev/null
rm -fr WEB-INF >> /dev/null

# Remplacement des paramètres
chmod +x $SCRIPT_PATH/bin/yq_linux_amd64
cat /opt/crcesu/crm/crm-api.yml | $SCRIPT_PATH/bin/yq_linux_amd64 w - spring.datasource.url "jdbc:db2://$BDD_HOST:$BDD_PORT/$BDD_NAME" | tee /opt/crcesu/crm/crm-api.yml.tmp && mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
if [ ! -z "$BDD_USER" ]
then
    cat /opt/crcesu/crm/crm-api.yml | $SCRIPT_PATH/bin/yq_linux_amd64 w - spring.datasource.username $BDD_USER | tee /opt/crcesu/crm/crm-api.yml.tmp && mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$BDD_PASSWORD" ]
then
    cat /opt/crcesu/crm/crm-api.yml | $SCRIPT_PATH/bin/yq_linux_amd64 w - spring.datasource.password $BDD_PASSWORD | tee /opt/crcesu/crm/crm-api.yml.tmp && mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$BDD_SCHEMA" ]
then
    cat /opt/crcesu/crm/crm-api.yml | $SCRIPT_PATH/bin/yq_linux_amd64 w - spring.datasource.hikari.data-source-properties.currentSchema $BDD_SCHEMA | tee /opt/crcesu/crm/crm-api.yml.tmp && mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$LOGSTASH_ENABLED" ]
then
    cat /opt/crcesu/crm/crm-api.yml | $SCRIPT_PATH/bin/yq_linux_amd64 w - jhipster.logging.logstash.enabled $LOGSTASH_ENABLED | tee /opt/crcesu/crm/crm-api.yml.tmp && mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$LOGSTASH_HOST" ]
then
    cat /opt/crcesu/crm/crm-api.yml | $SCRIPT_PATH/bin/yq_linux_amd64 w - jhipster.logging.logstash.host $LOGSTASH_HOST | tee /opt/crcesu/crm/crm-api.yml.tmp && mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$LOGSTASH_PORT" ]
then
    cat /opt/crcesu/crm/crm-api.yml | $SCRIPT_PATH/bin/yq_linux_amd64 w - jhipster.logging.logstash.port $LOGSTASH_PORT | tee /opt/crcesu/crm/crm-api.yml.tmp && mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$LOGSTASH_SIZE" ]
then
    cat /opt/crcesu/crm/crm-api.yml | $SCRIPT_PATH/bin/yq_linux_amd64 w - jhipster.logging.logstash.queue-size $LOGSTASH_SIZE | tee /opt/crcesu/crm/crm-api.yml.tmp && mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$CRCESU_PASSWORD_ENDPOINT" ]
then
    cat /opt/crcesu/crm/crm-api.yml | $SCRIPT_PATH/bin/yq_linux_amd64 w - application.service.ws.endpoint $CRCESU_PASSWORD_ENDPOINT | tee /opt/crcesu/crm/crm-api.yml.tmp && mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$CRCESU_PASSWORD_TIMEOUT" ]
then
    cat /opt/crcesu/crm/crm-api.yml | $SCRIPT_PATH/bin/yq_linux_amd64 w - application.service.ws.timeout $CRCESU_PASSWORD_TIMEOUT | tee /opt/crcesu/crm/crm-api.yml.tmp && mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$CRCESU_PASSWORD_HEADER_API" ]
then
    cat /opt/crcesu/crm/crm-api.yml | $SCRIPT_PATH/bin/yq_linux_amd64 w - application.service.ws.header.x-apikey $CRCESU_PASSWORD_HEADER_API | tee /opt/crcesu/crm/crm-api.yml.tmp && mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$FILE_MOUNT_POINT" ]
then
    cat /opt/crcesu/crm/crm-api.yml | $SCRIPT_PATH/bin/yq_linux_amd64 w - application.file.mount-point $FILE_MOUNT_POINT | tee /opt/crcesu/crm/crm-api.yml.tmp && mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
if [ ! -z "$UPLOAD_MOUNT_POINT" ]
then
    cat /opt/crcesu/crm/crm-api.yml | $SCRIPT_PATH/bin/yq_linux_amd64 w - application.file.upload-dir $UPLOAD_MOUNT_POINT | tee /opt/crcesu/crm/crm-api.yml.tmp && mv /opt/crcesu/crm/crm-api.yml.tmp /opt/crcesu/crm/crm-api.yml >> /dev/null
fi
cp /opt/crcesu/crm/crm-api.yml /opt/crcesu/crm/crm-api-$1.yml >> /dev/null
chown -R crcesu-crm:crcesu-crm /opt/crcesu/crm >> /dev/null

# Création du service
cp $SCRIPT_PATH/templates/back/crm-api.service /etc/systemd/system/crm-api.service >> /dev/null

# Démarrage
systemctl enable crm-api.service >> /dev/null
systemctl start crm-api.service >> /dev/null

# Clean
rm -fr crm-api-app-$1.war >> /dev/null