#!/bin/bash

# Konfigurace připojení k databázi
DB_USER="root"          # Změň podle potřeby
DB_PASS="tvoje_heslo"   # Změň podle potřeby
DB_NAME="wordpress"     # Název databáze WordPressu
TABLE_NAME="wp_options" # Název tabulky (změň, pokud máš jiný prefix)

# Získání aktuální IP adresy serveru
CURRENT_IP=$(hostname -I | awk '{print $1}')
if [[ -z "$CURRENT_IP" ]]; then
    echo "Chyba: Nepodařilo se zjistit IP adresu!"
    exit 1
fi

echo "Aktualizuji WordPress URL na IP: $CURRENT_IP"

# Aktualizace URL v databázi
mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
  UPDATE $TABLE_NAME SET option_value = 'http://$CURRENT_IP' WHERE option_name IN ('siteurl', 'home');
"

# Restart Apache pro zajištění správného fungování
systemctl restart apache2

echo "Aktualizace dokončena!"
