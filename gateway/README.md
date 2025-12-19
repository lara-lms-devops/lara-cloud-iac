# Deploy dos gateways

Para criar os gateways basta realizar o deploy do manifesto contido no arquivo [gateway-manifest.yaml](gateway-manifest.yaml) basta realizar o deploy do comando abaixo:

```shell
kubectl apply -f gateway-manifest.yaml
```

Este manifesto conta com 3 gateways, uma para cada ambiente (cloud, LARA dev e LARA prod). Todos possuem 2 _listeners_ para os protocolos HTTP e HTTPS.

# Deploy rotas do ambiente de cloud

Para realizar o deploy das rotas HTTP do ambiente de cloud basta executar o comando abaixo:

```shell
kubectl apply -f cloud-routes.yaml
```
