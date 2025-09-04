# Reco

**NMAP**\
-oN = output file\
-sC = scripts\
-sV = version\
-A = vše\
-p- = všechny porty\
-sN = scan live hostů\
-PR -sN = ARP scan hostů\
\--max-rate = určuje počet požadavku za sekundu (max 100, ideal davat v realu pod 1, např. 0.1)\
\
-sudo a specifikovat porty pro jejich hlubší reko

**GOBUSTER**\
-dir = adresáře\
gobuster dir  -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -u IP/URL\
\
-vhost = subdomény \
gobuster vhost -w /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-5000.txt -u http://thetoppers.htb\
\
-dns = subdomény (potřeba použít -d)\
\
**FFUF**\
ffuf -u http://domain.com -w WORDLIST -H"Host:FUZZ.domain.com" -fs 154 = subdomény









