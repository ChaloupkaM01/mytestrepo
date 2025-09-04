# Databáze

**Redis**\
redis-cli = připojení

info = info o databazi (např. počet klíčů)\
keys \* = vypíše všechny klíče\
get KEY = vypíše konkrétní hodnotu klíče



**Mongo**

```
curl -O https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.4.7.tgz
tar xvf mongodb-linux-x86_64-3.4.7.tgz
cd mongodb-linux-x86_64-3.4.7/bin
./mongo mongodb://{target_IP}:27017
```

```
show dbs;
use DB;
show collections;
db.COLLECTION.find().pretty()
```

\
**MySQL (**[**https://www.mysqltutorial.org/mysql-cheat-sheet/**](https://www.mysqltutorial.org/mysql-cheat-sheet/)**)**

```terminal
mysql --host=IP --port=PORT --user=NAME --password=PASS
mysql -h IP -P PORT -u NAME -p PASS
```
