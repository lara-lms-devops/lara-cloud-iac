## Realizar deploy dos secrets

Para realizar o deploy do secret do keycloak execute o comando abaixo:

```shell
KEYCLOAK_ADMIN= KEYCLOAK_ADMIN_PASSWORD= envsubst < keycloak-secret.yaml | kubectl apply -f -
```

Em que:

- KEYCLOAK_ADMIN: nome de usuário para a conta temporária de admin do keycloak
- KEYCLOAK_ADMIN_PASSWORD: senha para a conta temporária de admin do keycloak

Para realizar o deploy do secret de banco de dados execute o comando abaixo:

```shell
PASSWORD= envsubst < postgres-secret.yaml | kubectl apply -f -
```

Em que:

- PASSWORD: senha do banco de dados para o keycloak

## Realizar deploy do service manifest

Para realizar o deploy do keycloak basta executar o comando abaixo:

```shell
kubectl apply -f keycloak.yaml
```
