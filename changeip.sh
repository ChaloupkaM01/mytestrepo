#!/bin/bash

# Konfigurace připojení k databázi
DB_USER="wpadmin"
DB_PASS="extrasilneheslo+25"
DB_NAME="wordpress"
TABLE_PREFIX="wp01DP_"

# Získání aktuální IP adresy serveru
CURRENT_IP=$(hostname -I | awk '{print $1}')
if [[ -z "$CURRENT_IP" ]]; then
    echo "Chyba: Nepodařilo se zjistit IP adresu!"
    exit 1
fi

echo "Probíhá aktualizace všech IP adres na http://$CURRENT_IP"

# Funkce pro aktualizaci IP adres v tabulce
update_ip_addresses() {
    local table=$1
    local column=$2
    mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
        UPDATE $table 
        SET $column = REGEXP_REPLACE($column, 'http://[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+', 'http://$CURRENT_IP')
        WHERE $column REGEXP 'http://[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+';
    "
}

# Aktualizace v různých tabulkách
mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    -- Aktualizace základních URL
    UPDATE ${TABLE_PREFIX}options SET option_value = 'http://$CURRENT_IP' WHERE option_name IN ('siteurl', 'home');
    UPDATE ${TABLE_PREFIX}options SET option_value = 'http://$CURRENT_IP/wp-content/uploads' WHERE option_name = 'upload_url_path';
"

# Aktualizace IP adres v různých tabulkách
update_ip_addresses "${TABLE_PREFIX}posts" "post_content"
update_ip_addresses "${TABLE_PREFIX}posts" "guid"
update_ip_addresses "${TABLE_PREFIX}postmeta" "meta_value"
update_ip_addresses "${TABLE_PREFIX}options" "option_value"
update_ip_addresses "${TABLE_PREFIX}usermeta" "meta_value"
update_ip_addresses "${TABLE_PREFIX}comments" "comment_content"
update_ip_addresses "${TABLE_PREFIX}links" "link_url"
update_ip_addresses "${TABLE_PREFIX}links" "link_image"

echo "Provedena komplexní aktualizace IP adres v databázi"

# Restart služeb
systemctl restart apache2
systemctl restart mariadb
