kubectl apply -f gateway-manifest.yaml 
# TODO check if need to wait for the gateway
kubectl apply -f cloud-routes.yaml -f dev-routes.yaml 
