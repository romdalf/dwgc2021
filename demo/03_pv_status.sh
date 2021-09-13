echo ""
echo "--> current storageclass"
echo "kubectl get nodes"
kubectl get storageclass
echo "--> check PVC"
echo "kubectl get pvc -A"
kubectl get pvc -A -o wide
echo ""
echo "--> check PVs"
echo "kubectl get pv"
kubectl get pv -o wide
echo ""
echo "--> check PVs from a StorageOS view"
kubectl exec -n kube-system -it cli -- storageos get volumes -A -o wide
