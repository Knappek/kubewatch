# Kubewatch

This is a fork of [bitname-labs/kubewatch](https://github.com/bitnami-labs/kubewatch) and simplifies everything to only include Slack webhook. I did this to learn how to write a Kubernetes custom controller. 

## Usage

Build the code and upload it to your Dockerhub

```shell
make docker-push GITHUB_USERNAME=knappek
```

Adapt `image` in [kubewatch.yaml](./kubewatch.yaml#9) and the Slack Token in [kubewatch-configmap.yaml](./kubewatch-configmap.yaml#10).

Finally, apply it to a Kubernetes cluster

```shell
kubectl apply -f kubewatch-configmap.yaml -f kubewatch-service-account.yaml -f kubewatch.yaml
```