kubectl run \
  --namespace arc-system  \
  --overrides='{ "spec": { "serviceAccount": "gha-runner-scale-set-controller-gha-rs-controller" }  }' \
  --labels "app.kubernetes.io/name=gha-rs-controller" \
  -i --rm --tty "debug-$RANDOM" \
  --restart=Never \
  --image=alpine/k8s:1.32.5 \
  --command sh
