#!/bin/bash
# Script d'installation de NGinx pour héberger le site CRCESU CRM

# Params
# $1 : update 0|1

##################### Pré-requis #####################
# L'utilisateur doit avoir le droit d'utiliser sudo
#####################################################


if [ $1 -eq 0 ]
then
    # Installation de NGinx
    sudo apt-get install -y nginx >> /dev/null

    # Suppression configuration par défaut
    sudo rm /etc/nginx/sites-enabled/default >> /dev/null
    sudo rm /etc/nginx/sites-available/default >> /dev/null

    # Start NGinx & autostart
    sudo service nginx start >> /dev/null
    sudo systemctl enable nginx >> /dev/null
fi

# Init configuration
sudo cp $SCRIPT_PATH/templates/nginx/crm.conf /etc/nginx/sites-available/crm.conf >> /dev/null

# Disable SSL
if [ $SSL_ENABLED -eq 0 ]
then
    sudo sed -i s/ssl/\#ssl/g /etc/nginx/sites-available/crm.conf >> /dev/null
    sudo sed -i s#"443;"#"80;"#g /etc/nginx/sites-available/crm.conf >> /dev/null
fi

# Remplacement des variables
sudo sed -i s#"<SERVER_NAME>"#"$SERVER_NAME"#g /etc/nginx/sites-available/crm.conf >> /dev/null
sudo sed -i s#"<SSL_CHAIN_FILE>"#"$SSL_CHAIN_FILE"#g /etc/nginx/sites-available/crm.conf >> /dev/null
sudo sed -i s#"<SSL_KEY_FILE>"#"$SSL_KEY_FILE"#g /etc/nginx/sites-available/crm.conf >> /dev/null

# Activation du site
sudo rm -fr /etc/nginx/sites-enabled/crm.conf >> /dev/null
sudo ln -s /etc/nginx/sites-available/crm.conf /etc/nginx/sites-enabled/crm.conf >> /dev/null

# Reload Nginx
sudo nginx -s reload >> /dev/null
