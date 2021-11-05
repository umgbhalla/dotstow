knodestatus() {
    kubectl get nodes -o go-template='{{range .items}}{{$node := .}}{{range .status.conditions}}{{if ne .type "Ready"}}{{if eq .status "True"}}{{$node.metadata.name}}{{" "}}{{.type}}{{" "}}{{.status}}{{"\n"}}{{end}}{{else}}{{if ne .status "True"}}{{$node.metadata.name}}{{": "}}{{.type}}{{": "}}{{.status}}{{"\n"}}{{end}}{{end}}{{end}}{{end}}' | column -t
}

kexecpodmany() {
    PODS=($(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep $1))
    shift
    for i in $PODS; do
        echo "${i}"
        kubectl exec "${i}" -- "$@"
    done
}

knodeips() {
    kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}
        {.status.addresses[?(@.type=="ExternalIP")].address}{"\n"}{end}'
}

kgetall() {
    kubectl api-resources --verbs=list -o name | xargs -P50 -n1 kubectl get -o name
}

knodepodsall() {
     kubectl get pods --all-namespaces -o json \
       | jq '.items
            | map({podName: .metadata.name, nodeName: .spec.nodeName})
            | group_by(.nodeName)
            | map({node: .[0].nodeName, pods: map(.podName)})'
}

knodepods() {
     N="${1:-$(knode)}"
     knodepodsall \
       | jq --arg NODE "$N" '.[] | select(.node == $NODE)'
}

kpods() {
    kubectl get pods --no-headers -o custom-columns=":metadata.name" | fzf
}

kdeployment() {
    kubectl get deployment --no-headers -o custom-columns=":metadata.name" | fzf
}

kconfigmap() {
    kubectl get configmap --no-headers -o custom-columns=":metadata.name" | fzf
}

kdd() {
    kubectl describe deployment/$(kdeployment)
}

kgetpvc() {
    kubectl get pvc --no-headers --no-headers -o custom-columns=":metadata.name" | fzf
}

kdp() {
    kubectl describe pod/$(kpods)
}

kgpvcy() {
    kubectl get pvc/$(kgetpvc) -o yaml
}

kgpy() {
    local POD=$(kpods)
    vim -c 'set syntax=yaml' <(kubectl get pods $POD -o yaml)
}

kgdy() {
    local DEPLOYMENT=$(kdeployment)
    vim -c 'set syntax=yaml' <(kubectl get deployment $DEPLOYMENT -o yaml)
}

kgcy() {
    local CONFIGMAP=$(kconfigmap)
    vim -c 'set syntax=yaml' <(kubectl get configmap $CONFIGMAP -o yaml)
}

kpodsns() {
    kubectl get pods -n $1 --no-headers -o custom-columns=":metadata.name" | fzf
}

kns() {
    kubectl get ns --no-headers -o custom-columns=":metadata.name" | fzf
}

knode() {
    kubectl get nodes --no-headers -o wide | awk '{print $1}' | fzf
}

kshellall(){
    local NS=$(kns)
    kubectl exec -it -n $NS $(kpodsns $NS) -- /bin/sh -c "bash"
}

kexec() {
    kubectl exec $(kpods) -- "$@"
}

kdrain() {
    kubectl drain $1 --disable-eviction --delete-local-data --ignore-daemonsets --force > /dev/null &
    kubectl drain $1 --delete-local-data --ignore-daemonsets --force
}

kdescribe() {
    kubectl describe pod/$(kpods)
}

kshowsecret() {
    local SECRET=$(kubectl get secret --no-headers -o wide | awk '{print $1}' | fzf)
    kubectl get secret $SECRET -o json | jq '.data | map_values(@base64d)'
}

kdesc() {
    kdescribe
}

kcephpw() {
    kubectl get secret rook-ceph-dashboard-password \
      -o jsonpath="{['data']['password']}" \
      | base64 --decode \
      | xclip
}

knodepvc() {
  local PVC=$(kubectl get pvc --no-headers -o custom-columns=":metadata.name" | fzf)
  local POD=$(kubectl get pod --no-headers -o custom-columns=":metadata.name" | fzf)
  local VOLUME=$(kubectl get pvc $PVC -o custom-columns=":spec.volumeName" --no-headers)
  local NODE=$(kubectl get pod $POD -o custom-columns=":spec.nodeName" --no-headers)
  ssh -t -o StrictHostKeyChecking=no root@$NODE "cd /var/lib/kubelet/plugins/kubernetes.io/csi/pv/$VOLUME/globalmount; bash"
}

klogsall() {
    local NS=$(kns)
    kubectl logs -n $NS $(kpodsns $NS) -f
}

kportall() {
    local NS=$(kns)
    kubectl port-forward \
      -n $NS $(kubectl get pods -n $NS | awk '{print $1}' | fzf) $1:$1
}

kport() {
    kubectl port-forward $(kpods) $1:$1
}

klogs() {
    local POD=$(kpods)
    local CONS=$(kubectl get pods $POD -o json | jq -r '.spec.containers[].name')
    if [ "$(echo $CONS | wc -l)" -lt "2" ]; then
        kubectl logs $POD -f
    else
        kubectl logs $POD -c $(echo $CONS | fzf) -f
    fi
}

kshell() {
    local POD=$(kpods)
    local CONS=$(kubectl get pods $POD -o json | jq -r '.spec.containers[].name')
    local CMD="(while :; do sleep 1h && echo ping; done) & clear; cat /etc/os-release; (bash || ash || sh);"
    if [ "$(echo $CONS | wc -l)" -lt "2" ]; then
        kubectl exec -it $POD "--" sh -c $CMD
    else
        kubectl exec -it $POD -c $(echo $CONS | fzf) "--" sh -c $CMD
    fi
}

krootshell() {
    local POD="$(kpods)"
    local CONS=$(kubectl get pods $POD -o json | jq -r '.spec.containers[].name')
    if [ "$(echo $CONS | wc -l)" -lt "2" ]; then
        local CON_ID=$(kubectl describe pod $POD | grep "Container ID" | cut -f3- -d/)
        local NODE=$(kubectl describe pod $POD | grep "Node:" | cut -f2 -d/)
        ssh -t -o StrictHostKeyChecking=no root@$NODE docker exec -ti -u root $CON_ID /bin/bash
    else
        local CON_ID=$(kubectl describe pod $POD | grep -C 3 "$(echo $CONS | fzf)" | grep "Container ID" | cut -f3- -d/)
        local NODE=$(kubectl describe pod $POD | grep "Node:" | cut -f2 -d/)
        ssh -t -o StrictHostKeyChecking=no root@$NODE docker exec -ti -u root $CON_ID /bin/bash
    fi
}


kdebugshell() {
    kubectl exec -it $(kpods) "--" sh -c "
      yum install -y vim bind-utils curl bash;
      apt-get update && apt-get install -y vim curl dnsutils bash;
      apk add vim bind-tools net-tools curl bash rclone;
      clear;
      cat /etc/os-release;
      (bash || ash || sh);
      "
}


kdebugpod() {
    cat <<'EOF' | kubectl create -f -
apiVersion: v1
kind: Pod
metadata:
  name: alpine-debug-pod
spec:
  containers:
    - image: alpine
      name: alpine-debug-pod
      command: ["/bin/sh"]
      args: ["-c", "sleep infinity"]
EOF
}

kpvcclone() {
    if [ $# -eq 0 ]
      then return
    fi
    local PVC=$(kubectl get pvc --no-headers --no-headers -o custom-columns=":metadata.name" | fzf)
    local SIZE=$(kubectl get pvc $PVC --no-headers --no-headers -o custom-columns=":spec.resources.requests.storage")
    # cat <<'EOF' | kubectl create -f -
    cat <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: $1
spec:
  dataSource:
    name: $PVC
    kind: PersistentVolumeClaim
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: $SIZE
EOF
}


ke() {
    kubectl get events -A --field-selector type=Warning -o json \
      | jq '[.items | .[] | {
          message,
          reason,
          name: .metadata.name,
          host: .source.host
      }]'
}

knodeshell() {
    ssh -o StrictHostKeyChecking=no root@$(knode | awk '{print $2}')
}

kneat() {
    ((!$#)) && { kubectl-neat | bat -l yaml } || { kubectl-neat -f $1 | bat -l yaml }
}

kcephstatus() {
    local cephstatus=$(kubectl get CephCluster -A -o json \
      | jq -r '[.items[] | {
              name: .metadata.name,
              version: .spec.cephVersion.image,
              mon_count: .spec.mon.count,
              status: { details: .status.ceph.details },
              health: .status.ceph.health
            }]')
    if [[ $* == *--details* ]] then
      echo $cephstatus | jq
    else
      echo $cephstatus \
          | jq -r '.[] | "\(.name)\t\(.version)\t\(.mon_count)\t\(.health)"' \
          | column -t
    fi
}

kcephshell() {
   kubectl exec -n $1 -it $(kubectl get pods -n $1 \
     | grep "rook-ceph-tools" \
     | cut -d' ' -f1) -- /bin/bash -c "ceph status; bash"
}

knumpodspernode() {
    kubectl get pods --all-namespaces -o json \
      | jq '.items[] | .spec.nodeName' -r \
      | sort \
      | uniq -c \
      | sort -nr
}

kcrash() {
    kubectl get pods -A | grep CrashLoopBackOff
}

knodeuptimes() {
    kubectl get nodes -o wide --no-headers\
      | awk '{print $1}' \
      | xargs -n 1 -P 20 -I {} kubectl-node_shell {} -- sh -c 'echo $(hostname) $(uptime)' \
      | grep -v nsenter \
      | awk '{print $1, $4, $5}' \
      | tr -d "," \
      | column -t
}

knodepod() {
    kubectl get pod -o=custom-columns=NODE:.spec.nodeName,NAME:.metadata.name
}
alias knodepods=knodepod
alias knp=knodepod

kexecnode() {
    ssh -o StrictHostKeyChecking=no root@$(knode | awk '{print $2}') -C "$@"
}

kexecnodes(){
    kgn --no-headers \
      | awk '{print $1}' \
      | xargs -I {} kubectl-node_shell {} -- sh -c "$@"
}

kswitchnamespace() {
    kubectl config set-context --current --namespace=$(kns)
    kubectl get pods
}

alias kswitchns=kswitchnamespace
alias ksn=kswitchnamespace

kswitchcontext() {
    kubectl config get-contexts --no-headers \
      | awk '{print $2}' \
      | fzf \
      | xargs -I {} kubectl config use-context {}
}

alias kswitchctx=kswitchcontext
alias ksctx=kswitchcontext
alias ksc=kswitchcontext
alias k='kubectl'
alias kgn='kubectl get nodes -o wide'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployment'
alias kge='kubectl get events'
alias kgpvc='kubectl get pvc'

