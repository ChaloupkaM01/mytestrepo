# Privilage escalation

**Zjištění verze kernelu a OS (kernel exploit)**\
uname -a

**Kontrola suda**\
sudo -v\
sudo -l\
\
**Zneužitelné soubory (SUID)**\
find / -perm -u=s -type f 2>/dev/null

**Složky**\
/opt/mail\
/var/mail\
/var/www -> databáze?

**Proměnné**\
$PATH\
env

**SSH Tunnel**\
-Pomocí **nestat -ntlp** zjistíme jestli neběží podezřelá komunikace ven\
-Pro přesměrování:

```
ssh -L MY_PORT:localhost:REMOTE_PORT USER@REMOTE_IP
localhost:MY_PORT
```





