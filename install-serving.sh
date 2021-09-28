set -ex

kubectl apply -f https://github.com/knative/serving/releases/latest/download/serving-crds.yaml
kubectl apply -f https://github.com/knative/serving/releases/latest/download/serving-core.yaml
kubectl apply -f https://github.com/knative/net-kourier/releases/latest/download/kourier.yaml
kubectl patch configmap/config-network \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"ingress.class":"kourier.ingress.networking.knative.dev"}}'
kubectl -n knative-serving wait --for=condition=Available deployments --all

kubectl apply -f https://github.com/knative/serving/releases/latest/download/serving-default-domain.yaml
kubectl apply -f https://github.com/knative/serving/releases/latest/download/serving-post-install-jobs.yaml
kubectl -n knative-serving wait --for=condition=Complete jobs --all
