# Deploy Woodpecker CI

# Create Woodpecker secrets
# OK TODO add agent secret as a random string generated with "openssl rand -hex 32"
# OK TODO ask in for input to get the github information
# TODO maybe use cloudflare tunnel to expose this and it work with github

#!/bin/bash
read -p 'Cole o client id do OAuth App do Github' -s GITHUB_CLIENT_ID
read -p 'Cole o secret do OAuth App do Github' -s GITHUB_SECRET
AGENT_SECRET =  $(openssl rand -hex 32)

echo 'Criando segredos para o Woodpecker'
kubectl create secret generic woodpecker-secret \
  --from-literal=WOODPECKER_AGENT_SECRET='$AGENT_SECRET' \
  --from-literal=WOODPECKER_GITHUB_CLIENT='$GITHUB_CLIENT_ID' \
  --from-literal=WOODPECKER_GITHUB_SECRET='$GITHUB_SECRET' \
  -n default

unset AGENT_SECRET
unset GITHUB_CLIENT_ID
unset GITHUB_SECRET

echo 'Deployando Woodpecker'
kubectl apply -f woodpecker.yaml
