# Day 15 - Active Directory

**Útoky**\
**-**&#x47;olden ticket\
-Pass the hash\
-Kerberoasting\
-Pass the ticket \
-Malicious GPO\
-Skeleton Key

```powershell
Get-GPO -All   //politiky
Get-GPOReport -Name "SetWallpaper" -ReportType HTML -Path ".\SetWallpaper.html"  //export politiky
Get-GPO -All | Where-Object { $_.ModificationTime } | Select-Object DisplayName, ModificationTime   //modifikované

Get-ADUser -Filter * -Properties MemberOf | Select-Object Name, SamAccountName, @{Name="Groups";Expression={$_.MemberOf}}  //vypis AD uživatelů

%APPDATA%\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt  //historie powershellu
Application and Services Logs -> Microsoft -> Windows -> PowerShell -> Operational
Application and Service Logs -> Windows PowerShell
```
