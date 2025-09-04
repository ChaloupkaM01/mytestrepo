# Day 22 - DFIR kubernetes

Kubernetes = orchestrátor pro kontejnery (např. při přetížení jedné microservice se vytvoří další instance/kontejner pro load balancing)

Pody - Nody - Clustery

Kontejnery žijí cca 5 minut (proto je DFIR kubernetes obtížný)

Řešení:\
-zapnutí logování kubernetes\
-odchyt requestu na vícero místech

```shell-session
minikube start   //start kubernetes
kubectl get pods -n wareville    //zobrazení podů v daném namespacu
kubectl exec -n wareville naughty-or-nice -it -- /bin/bash   //připojení do podu

docker ps   //vypsání aktivních kontejnerů
docker exec CONT_ID ls - al /var/log  //provede příkaz (zde vypsání) v konkrétním kontejneru
docker logs CONT_ID   //logy kontejneru
```
