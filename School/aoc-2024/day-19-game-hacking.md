# Day 19 - Game hacking

Knihovna = soubor funkcí který je samostatně k ničemu, využíval EXE hry

Frida = slouží k odchytu komunikace s knihovnou, umožňuje její úpravu

`frida-trace ./FILE -i '*' //vytvoří handler na každou knihovnu`

Končí-li handler na:

i = argument je INT\
iii = argumenty jsou 3 INTy\
Pkc = argument je STRING

```shell-session
frida-trace ./FILE -i 'KNIHOVNA!*'
```

Handlery lze upravit za účelem vypsání argumentů

```javascript
defineHandler({
  onEnter(log, args, state) {
    log('_Z17validate_purchaseiii()');
    log('PARAMETER 1: '+ args[0]);
    log('PARAMETER 2: '+ args[1]);
    log('PARAMETER 3: '+ args[2]);
  },

  onLeave(log, retval, state) {  
  }
});
```

Argumenty lze potom upravit podle požadavků

```javascript
defineHandler({
  onEnter(log, args, state) {
    log('_Z17validate_purchaseiii()');
    args[1] = ptr(0)
  },

  onLeave(log, retval, state) {
  }
});
```

Občas je potřeba vypsat return value místo argumentů

```javascript
defineHandler({
  onEnter(log, args, state) {
    log('_Z16check_biometricsPKc()');
    log("PARAMETER:" + Memory.readCString(args[0]))
  },

  onLeave(log, retval, state) {
    log("The return value is: " + retval);
  }
});
```
