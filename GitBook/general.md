# General

**PHP shell stabilization** \
python3 -c 'import pty;pty.spawn("/bin/bash")'\
\
\
**WGET**\
wget --recursive --no-parent \<URL> = stáhne celý adresář

\
**CURL**\
curl -X \<metoda> \<URL> = vznešení požadavku\


**FTP**\
účet anonymous login bez hesla\
get = stáhnutí\


**SMB**\
**smbclient** = prohlížení\
&#x20;  -L = IP (list shares)\
&#x20;  -N = no login\
&#x20; \
smbclient //IP/SHARE = connect na share\
\
**Xfreerdp** (RDP)\
/:v IP:PORT        /:u USER        /:p password\
\
\
**RSYNC**\
rsync --list-only {target\_IP}::      (čtení shares a filů)

rsync IP::SHARE/FILE.txt DESTINATION    (stahování filů)\


**AWS**\
aws --endpoint="http://s3.thetoppers.htb" s3 ls\
aws --endpoint="http://s3.thetoppers.htb" s3 ls s3://thetoppers.htb

aws --endpoint="http://s3.thetoppers.htb" s3 cp phpShell.php s3://thetoppers.htb



