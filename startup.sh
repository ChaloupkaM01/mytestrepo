#!/bin/bash

# Získání IP adresy
clear
IP_ADDR=$(hostname -I | awk '{print $1}')

# Vyzvání k zadání jména studenta
echo "Zadejte své jméno:"
read STUDENT_NAME

# Generování flagů
FLAGS=("FLAG-$(openssl rand -hex 4)" "FLAG-$(openssl rand -hex 4)" "FLAG-$(openssl rand -hex 4)" \
       "FLAG-$(openssl rand -hex 4)" "FLAG-$(openssl rand -hex 4)" "FLAG-$(openssl rand -hex 4)" \
       "FLAG-$(openssl rand -hex 4)" "FLAG-$(openssl rand -hex 4)" "FLAG-$(openssl rand -hex 4)" \
       "FLAG-$(openssl rand -hex 4)")

# Výběr 5 náhodných flagů
SELECTED_FLAGS=($(shuf -e "${FLAGS[@]}" -n 5))

# Rozmístění flagů
echo "${SELECTED_FLAGS[0]}" > /var/www/html/robots.txt
sed -i "s/REPLACE_ME/${SELECTED_FLAGS[1]}/" /var/www/html/index.php
echo "${SELECTED_FLAGS[2]}" > /home/ctf/hidden_flag
echo "${SELECTED_FLAGS[3]}" >> /etc/passwd
echo "${SELECTED_FLAGS[4]}" > /var/tmp/tmp_flag

# Odeslání e-mailu učiteli
#echo -e "Student: $STUDENT_NAME\nFlags:\n${SELECTED_FLAGS[*]}" | mail -s "CTF Flags" profesor@example.com

# Zamknutí terminálu
#chown root:root /dev/tty1
#chmod 000 /dev/tty1

# Zobrazení pouze IP adresy
clear
echo "CTF běží na IP: $IP_ADDR"

exit 0
