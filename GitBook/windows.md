# Windows

**type** = vypíše obsah souboru\
**dir** \


**Responder**\
-vytvoří falešný SMB server na který můžeme poslat žádost o autentizaci pokud je na stránce povolené RFI (Remote File Inclusion) např pomocí PHP fce include()

sudo responder -I NET\_INT \
\
**WinRM (evil-winrm)**\
-služba pro vzdálený mgmt PC\
-port 5985, 5986



**RDP**

xfreerdp /u:USERNAME /p:PASSWORD /v:IP
