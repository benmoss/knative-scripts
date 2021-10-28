set -ex

kubectl apply -f https://github.com/jetstack/cert-manager/releases/latest/download/cert-manager.yaml
kubectl -n cert-manager wait --timeout=5m --for=condition=Available deployments --all

kubectl apply -f https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml
kubectl apply -f https://github.com/rabbitmq/messaging-topology-operator/releases/latest/download/messaging-topology-operator-with-certmanager.yaml
kubectl -n rabbitmq-system wait --timeout=5m --for=condition=Available deployments --all

kubectl -n knative-eventing wait --timeout 5m --for=condition=Available deployments --all
kubectl apply -f https://github.com/knative-sandbox/eventing-rabbitmq/releases/latest/download/rabbitmq-broker.yaml
kubectl -n knative-eventing wait --timeout=5m --for=condition=Available deployments --all
