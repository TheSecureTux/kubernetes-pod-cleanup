#! /bin/bash

if (($# == 0)); then
  echo "Please pass argumensts -n NAMESPACE -c CONTEXT"
  exit 2
fi


usage="$(basename "$0") [-h] [-s -n] -- Cleanup script for pods in error, crashloop, etc

where:
    -h  show this help text
    -c  set the context 
    -n  set the namespace "

while getopts ':hc:n:' option; do
    case "$option" in
    h) echo "$usage"
       exit
       ;;
    c) CONTEXT="$OPTARG"
       echo "Context set to $OPTARG"
    ;;
    n) NAMESPACE="$OPTARG"
       echo "Namespace set to $OPTARG"
    ;;
    \?)
    echo "Invalid option: -$OPTARG" >&2
    exit 1
    ;;
    esac
done

shift $((OPTIND - 1))

for pods in $(kubectl  --context $CONTEXT get pods  -n $NAMESPACE |grep -E 'Error|CrashLoopBackOff|ImagePullBackOff|ErrImagePull|Completed' | awk '{ print  $1 }') ;
 do kubectl --context $CONTEXT -n $NAMESPACE delete pods $pods --grace-period=0 --force ; 
 done
