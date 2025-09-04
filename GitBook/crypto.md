# Crypto

**John**\
\--format = určuje typ hashe\
\--wordlist\
-potřeba mít hash v .txt (nejlepší je okopírovat celý /etc/shadow záznam)\


**Crunch** = vytvoření wordlistu z předvolených charů

`crunch 3 3 0123456789ABCDEF -o 3digits.txt`\
`3 = minimum length`\
`3 = maximum length`\
`XY = custom charset`\
`-o = output file`

\
**Hydra**\
hydra -l ' ' -P list.txt 10.10.x.x http-post-form "/login.php:username=^USER^\&password=^PASS^:Access denied" -s 8000 -f -v

hydra -l USER -P WORDLIST IP ssh

-s = jiný port než 80\
-f = stop při nalezení\


**Wfuzz**\
wfuzz -c -z jmena.txt -z hesla.txt --hs "Please enter the correct credentials" -u http://10.10.34.254/login.php -d "username=FUZZ\&password=FUZ2Z"

-c = barvičky xd\
-z = připnutí souborů \
\--hs = schová odpovědi s chybovým stringem\
-u = URL\
-d = parametry POSTu, jednotlivé wordlisty číslem\
\
\
**Cewl** = vytvoří wordlist (usernames, hesla) z obsahu webové stránky\
-m = min délka (5)\
-x = max délka\
-d = hloubka crawlingu\
-w = output\
\--lowercase = pro jména\
\--with-numbers = pro hesla
