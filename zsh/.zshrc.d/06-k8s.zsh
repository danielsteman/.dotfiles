# 06-k8s.zsh
# -------------------------------------------------------------
# Kubernetes (kubectl) aliases and functions.

# Opening a bash shell in a pod
kshell() {
    if [ -z "$1" ]; then
        echo "Usage: kshell <pod-name>"
        return 1
    fi
    kubectl exec --stdin --tty "$1" -- /bin/bash
}

# Quickly run a debug container in the cluster
kdebug() {
    if [ -z "$1" ]; then
        echo "Usage: kdebug <image>"
        return 1
    fi
    kubectl run demo-worker -i --tty --image="$1" --restart=Never -- bash
}

# Get service YAML using FZF
kgsy() {
  local svc
  svc=$(kubectl get svc -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' | fzf)
  [ -n "$svc" ] && kubectl get svc "$svc" -o yaml
}

# Get pod YAML using FZF
kgpy() {
  local pod
  pod=$(kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' | fzf)
  [ -n "$pod" ] && kubectl get pod "$pod" -o yaml
}

