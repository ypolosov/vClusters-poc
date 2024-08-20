# vClusters-poc

https://lucabertelli.consulting/en/blog/vcluster/


```bash
helm repo add argo https://argoproj.github.io/argo-helm
helm install argo argo/argo-workflows --namespace argo --set server.extraArgs[0]="--auth-mode=server" --create-namespace

kubectl get pods -n argo

kubectl create clusterrolebinding argo-admin-server --clusterrole=cluster-admin --serviceaccount=argo:argo-server -n argo
kubectl create clusterrolebinding argo-admin-default --clusterrole=cluster-admin --serviceaccount=argo:default -n argo

# export GITHUB_TOKEN=******
kubectl create secret generic github-token -n argo --from-literal="token=$GITHUB_TOKEN"

# export DOCKER_USERNAME=******
# export DOCKER_TOKEN=******
kubectl create secret generic docker-config --from-literal="config.json={\"auths\": {\"https://ghcr.io/\": {\"auth\": \"$(echo -n $DOCKER_USERNAME:$DOCKER_TOKEN|base64)\"}}}"

git clone https://github.com/$GITHUB_USER/ephemeral-test-environment.git
cd ephemeral-test-environment/argo-workflow


kubectl apply -f ci.yaml
kubectl apply -f lang/go.yaml
kubectl apply -f cd.yaml

vcluster list
vcluster connect demo-pr-request -n demo-pr-request
vcluster disconnect
```