#!/bin/bash
# Script d'installation de NGinx pour héberger le site CRCESU CRM

# Params
# $1 : update 0|1

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit root
#####################################################


if [ $1 -eq 0 ]
then
    # Installation de NGinx
    apt-get install -y nginx >> /dev/null

    # Suppression configuration par défaut
    rm /etc/nginx/sites-enabled/default >> /dev/null
    rm /etc/nginx/sites-available/default >> /dev/null

    # Start NGinx & autostart
    service nginx start >> /dev/null
    systemctl enable nginx >> /dev/null
fi

# Init configuration
cp $SCRIPT_PATH/templates/nginx/crm.conf /etc/nginx/sites-available/crm.conf >> /dev/null

# Disable SSL
if [ $SSL_ENABLED -eq 0 ]
then
    sed -i s/ssl/\#ssl/g /etc/nginx/sites-available/crm.conf >> /dev/null
    sed -i s#"443;"#"80;"#g /etc/nginx/sites-available/crm.conf >> /dev/null
fi

# Remplacement des variables
sed -i s#"<SERVER_NAME>"#"$SERVER_NAME"#g /etc/nginx/sites-available/crm.conf >> /dev/null
sed -i s#"<SSL_CHAIN_FILE>"#"$SSL_CHAIN_FILE"#g /etc/nginx/sites-available/crm.conf >> /dev/null
sed -i s#"<SSL_KEY_FILE>"#"$SSL_KEY_FILE"#g /etc/nginx/sites-available/crm.conf >> /dev/null

# Activation du site
rm -fr /etc/nginx/sites-enabled/crm.conf >> /dev/null
ln -s /etc/nginx/sites-available/crm.conf /etc/nginx/sites-enabled/crm.conf >> /dev/null

# Reload Nginx
nginx -s reload >> /dev/null
