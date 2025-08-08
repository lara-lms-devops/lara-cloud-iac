echo 'Adicionando repositorio do minio-operator no helm'
helm repo add minio-operator https://operator.min.io

echo 'Deployando MinIO usando helm no namespace minio-operator'
helm install \
  --namespace minio-operator \
  --create-namespace \
  operator minio-operator/operator

# TODO wait until it is read before creating tenant 
echo 'Verifica a instalação do MinIO'
kubectl get all -n minio-operator

# TODO add integration to keycloak with https://docs.min.io/community/minio-object-store/operations/external-iam.html
# Do this after testing
kubectl apply -f manifests/minio/tenant/lara-dev-tenant.yaml
