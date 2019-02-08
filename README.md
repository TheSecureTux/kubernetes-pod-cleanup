# kubernetes-pod-cleanup
Simple tool to clean pods on "Error", "Crashloop...", "Completed", etc from your cluster

# Usage:


clean-pods.sh [-h] [-s -n] -- Cleanup script for pods in error, crashloop, etc

where:
    -h  show this help text
    -c  set the context, as in  "kubectl --context=" (Required)
    -n  set the namespace (Required) 
    
 
