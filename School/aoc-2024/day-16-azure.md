---
description: Cloud Service Provider = poskytují výpočetní techniku na vyžádání
---

# Day 16 - Azure

Platíme jen za to co využijeme\


Azure Key Vault = slouží k uchovávání secertů (API klíče, hesla, certifikáty), vlastněny vault ownery, ti můžou povolovat přístup vault consumerum\


Microsoft Entra ID = IAMaaS -> identity and acces management as a service -> slouží k řízení přístupu ke zdrojům\
\
Azure Cloud Shell = Bash/Powershell k řízení Azure zdrojů



**Azure CLI commandy**

`az GROUP SUBGROUP ACTION OPTIONAL_PARAMETERS`

```shell-session
az ad signed-in-user show    //vypíše info o přihlášeném uživateli
az ad user list              //výpis uživatelů
az ad user list --filter "startsWith('wvusr-', displayName)"
az ad group list
az account clear        //odhlášení
az login -u EMAIL -p PASS //přihlášení
az role assignment list --assignee 7d96660a-02e1-4112-9515-1762d0cb66b7 --all  //výpis rolí, lze zjistit název vaultu a ID rolí
az keyvault list        //výpis vaultů
az keyvault secret list --vault-name NAME     //výpis secretů
az keyvault secret show --vault-name NAME --name NAME   //zobrazení secretu
```
