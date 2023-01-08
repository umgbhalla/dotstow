kluster-quick(){
k3d cluster create quick \
--servers 1 \
--agents 1 \
--api-port=6443 \
--port 8080:80@loadbalancer \
--wait
}

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
alias knps=knodepod
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

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#compdef kubectl
compdef _kubectl kubectl

# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#compdef _kubectl kubectl

# zsh completion for kubectl                              -*- shell-script -*-

__kubectl_debug()
{
    local file="$BASH_COMP_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_kubectl()
{
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16

    local lastParam lastChar flagPrefix requestComp out directive comp lastComp noSpace
    local -a completions

    __kubectl_debug "\n========= starting completion logic =========="
    __kubectl_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CURRENT location, so we need
    # to truncate the command-line ($words) up to the $CURRENT location.
    # (We cannot use $CURSOR as its value does not work when a command is an alias.)
    words=("${=words[1,CURRENT]}")
    __kubectl_debug "Truncated words[*]: ${words[*]},"

    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __kubectl_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"

    # For zsh, when completing a flag with an = (e.g., kubectl -n=<TAB>)
    # completions must be prefixed with the flag
    setopt local_options BASH_REMATCH
    if [[ "${lastParam}" =~ '-.*=' ]]; then
        # We are dealing with a flag with an =
        flagPrefix="-P ${BASH_REMATCH}"
    fi

    # Prepare the command to obtain completions
    requestComp="${words[1]} __complete ${words[2,-1]}"
    if [ "${lastChar}" = "" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go completion code.
        __kubectl_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __kubectl_debug "About to call: eval ${requestComp}"

    # Use eval to handle any environment variables and such
    out=$(eval ${requestComp} 2>/dev/null)
    __kubectl_debug "completion output: ${out}"

    # Extract the directive integer following a : from the last line
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __kubectl_debug "last line: ${lastLine}"

    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        # Remove the directive including the : and the newline
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
        # There is no directive specified.  Leave $out as is.
        __kubectl_debug "No directive found.  Setting do default"
        directive=0
    fi

    __kubectl_debug "directive: ${directive}"
    __kubectl_debug "completions: ${out}"
    __kubectl_debug "flagPrefix: ${flagPrefix}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        __kubectl_debug "Completion received error. Ignoring completions."
        return
    fi

    while IFS='\n' read -r comp; do
        if [ -n "$comp" ]; then
            # If requested, completions are returned with a description.
            # The description is preceded by a TAB character.
            # For zsh's _describe, we need to use a : instead of a TAB.
            # We first need to escape any : as part of the completion itself.
            comp=${comp//:/\\:}

            local tab=$(printf '\t')
            comp=${comp//$tab/:}

            __kubectl_debug "Adding completion: ${comp}"
            completions+=${comp}
            lastComp=$comp
        fi
    done < <(printf "%s\n" "${out[@]}")

    if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
        __kubectl_debug "Activating nospace."
        noSpace="-S ''"
    fi

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local filteringCmd
        filteringCmd='_files'
        for filter in ${completions[@]}; do
            if [ ${filter[1]} != '*' ]; then
                # zsh requires a glob pattern to do file filtering
                filter="\*.$filter"
            fi
            filteringCmd+=" -g $filter"
        done
        filteringCmd+=" ${flagPrefix}"

        __kubectl_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subdir
        subdir="${completions[1]}"
        if [ -n "$subdir" ]; then
            __kubectl_debug "Listing directories in $subdir"
            pushd "${subdir}" >/dev/null 2>&1
        else
            __kubectl_debug "Listing directories in ."
        fi

        local result
        _arguments '*:dirname:_files -/'" ${flagPrefix}"
        result=$?
        if [ -n "$subdir" ]; then
            popd >/dev/null 2>&1
        fi
        return $result
    else
        __kubectl_debug "Calling _describe"
        if eval _describe "completions" completions $flagPrefix $noSpace; then
            __kubectl_debug "_describe found some completions"

            # Return the success of having called _describe
            return 0
        else
            __kubectl_debug "_describe did not find completions."
            __kubectl_debug "Checking if we should do file completion."
            if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
                __kubectl_debug "deactivating file completion"

                # We must return an error code here to let zsh know that there were no
                # completions found by _describe; this is what will trigger other
                # matching algorithms to attempt to find completions.
                # For example zsh can match letters in the middle of words.
                return 1
            else
                # Perform file completion
                __kubectl_debug "Activating file completion"

                # We must return the result of this command, so it must be the
                # last command, or else we must store its result to return it.
                _arguments '*:filename:_files'" ${flagPrefix}"
            fi
        fi
    fi
}

# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_kubectl" ]; then
    _kubectl
fi
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
