# TODO install k3s here

# install and init MinIO operator
kubectl apply -k "github.com/minio/operator&ref=v5.0.11"
kubectl minio init

# kubectl create namespace lara-production
# kubectl minio tenant create lara-production-minio \
#   --namespace lara-production \
#   --servers 1 --volumes 4 --capacity 10Gi # TODO understand what those values means and tune them

kubectl create namespace lara-dev
# kubectl minio tenant create lara-staging-minio \
#   --namespace lara-staging \
#   --servers 1 --volumes 4 --capacity 10Gi 


# FROM OFFICIAL DOC
# Add minio-operator to helm
helm repo add minio-operator https://operator.min.io
helm install \
  --namespace minio-operator \
  --create-namespace \
  operator minio-operator/operator

# Check if everything is installed properly
kubectl get all -n minio-operator

kubectl create ns <tenant-namespace>

kubectl create secret generic oidc-secret \
  --from-literal=client-secret='<your-client-secret>' \
  -n <tenant-namespace>
  


