# Day 14 - Self-Signed certificate

Pokud aplikace používá self-signed certifikáty, lze je zneužít pro **man-in-the-middle**



1. (Přidání IP do /etc/hosts)
2. Burp - vypnutí interceptu - nastavení proxy listeneru - nastavení specifické IP našeho stroje
3. Přidání vlastní IP do /etc/hosts jako gateway (echo "MY\_IP wareville-gw" >> /etc/hosts)
4. View HTTP history
