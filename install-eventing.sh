set -ex

kubectl apply -f https://github.com/knative/eventing/releases/latest/download/eventing-crds.yaml
kubectl apply -f https://github.com/knative/eventing/releases/latest/download/eventing-core.yaml
kubectl apply -f https://github.com/knative/eventing/releases/latest/download/in-memory-channel.yaml
kubectl apply -f https://github.com/knative/eventing/releases/latest/download/mt-channel-broker.yaml
kubectl -n knative-eventing wait --timeout 5m --for=condition=Available deployments --all

kubectl create -f https://github.com/knative/eventing/releases/latest/download/eventing-post-install.yaml
kubectl -n knative-eventing wait --timeout 5m --for=condition=Complete jobs --all
