#!/bin/bash

# Definice proměnných
TEACHER_EMAIL="teacher@example.com"
SMTP_CONFIG="/etc/msmtprc"
LOG_FILE="/var/log/ctf_setup.log"
STUDENT_NAME=""
FLAGS=()

# Možná umístění flagů
LOCATIONS=(
    "/var/www/html/hidden_flag.txt"                        # 1. Directory bruteforce
    "/var/www/html/index.php"                              # 2. V komentáři ve zdrojovém kódu
    "/var/www/html/backup/backup_file.txt"                # 3. Backup folder
    "/var/www/html/robots.txt"                            # 4. robots.txt
    "/var/www/html/user_profiles?id=1337"                 # 5. IDOR
    "/var/www/html/download.php?file=../../etc/passwd"    # 6. Directory traversal
    "/var/www/html/wp-content/plugins/secret_plugin.txt"  # 7. WordPress plugin složka
    "/etc/apache2/apache2.conf"                           # 8. Apache config
    "/var/log/apache2/access.log"                         # 9. Apache access log
    "/var/www/html/.htpasswd"                             # 10. .htpasswd
)

# Vybere náhodných 5 umístění
SELECTED_LOCATIONS=($(shuf -e "${LOCATIONS[@]}" -n 5))

# Funkce pro generování náhodného flagu
generate_flag() {
    echo "FLAG-$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16)"
}

# Získání jména studenta
echo "Zadejte své jméno:"
read STUDENT_NAME

# Uložení flagů do souborů
for LOCATION in "${SELECTED_LOCATIONS[@]}"; do
    FLAG=$(generate_flag)
    FLAGS+=("$FLAG")
    
    # Vytvoření souboru, pokud neexistuje
    if [[ "$LOCATION" == *".php"* ]]; then
        echo "<?php /* $FLAG */ ?>" >> "$LOCATION"
    elif [[ "$LOCATION" == *".txt"* || "$LOCATION" == *".log"* ]]; then
        echo "$FLAG" >> "$LOCATION"
    elif [[ "$LOCATION" == *"apache2.conf"* ]]; then
        echo "# Flag: $FLAG" >> "$LOCATION"
    elif [[ "$LOCATION" == *".htpasswd"* ]]; then
        echo "admin:\$apr1\$$(openssl rand -base64 6)\$$(openssl rand -base64 12)" > "$LOCATION"
    fi
done

# Odeslání e-mailu učiteli
EMAIL_BODY="Student: $STUDENT_NAME\n\nFlagy:\n$(printf '%s\n' "${FLAGS[@]}")"

echo -e "Subject: CTF řešení - $STUDENT_NAME\n\n$EMAIL_BODY" | msmtp -a default "$TEACHER_EMAIL"

# Získání IP adresy a uzamčení terminálu
IP_ADDRESS=$(hostname -I | awk '{print $1}')
clear
echo "CTF virtuálka je připravena!"
echo "Přistupujte na: http://$IP_ADDRESS"
echo -e "\nPro správu stroje se přihlaste s root přístupem."

# Uzamčení terminálu
exec sleep infinity
