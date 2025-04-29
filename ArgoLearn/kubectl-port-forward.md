Link https://kubernetes.io/docs/reference/kubectl/generated/kubectl_port-forward/

[ec2-user@ip-172-31-41-130 tmp]$ kubectl get service -n argocd
NAME                                      TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
argocd-applicationset-controller          ClusterIP   10.101.240.214   <none>        7000/TCP,8080/TCP            3h
argocd-dex-server                         ClusterIP   10.108.184.64    <none>        5556/TCP,5557/TCP,5558/TCP   3h
argocd-metrics                            ClusterIP   10.105.47.203    <none>        8082/TCP                     3h
argocd-notifications-controller-metrics   ClusterIP   10.100.141.232   <none>        9001/TCP                     3h
argocd-redis                              ClusterIP   10.102.144.236   <none>        6379/TCP                     3h
argocd-repo-server                        ClusterIP   10.99.111.179    <none>        8081/TCP,8084/TCP            3h
argocd-server                             ClusterIP   10.100.171.211   <none>        80/TCP,443/TCP               3h
argocd-server-metrics                     ClusterIP   10.109.206.207   <none>        8083/TCP                     3h

Listening on Local Host :

[ec2-user@ip-172-31-41-130 tmp]$ kubectl port-forward svc/argocd-server 8080:443 -n argocd
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080


a:b -> a is the local port on vm (8080) and b is the target port of the pod/service (443)

[ec2-user@ip-172-31-41-130 tmp]$ kubectl port-forward svc/argocd-server 8080:443 -n argocd
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080

Getting Initial Password

[ec2-user@ip-172-31-41-130 ~]$ argocd admin initial-password -n argocd


ArgoCD Login:

[ec2-user@ip-172-31-41-130 ~]$ argocd login localhost:8080
WARNING: server certificate had error: tls: failed to verify certificate: x509: certificate signed by unknown authority. Proceed insecurely (y/n)? y
Username: admin
Password: 
'admin:login' logged in successfully
Context 'localhost:8080' updated
[ec2-user@ip-172-31-41-130 ~]$ 


Listening on External Host/Browser

[ec2-user@ip-172-31-41-130 tmp]$ kubectl port-forward --address 0.0.0.0 svc/argocd-server 8080:443 -n argocd
Forwarding from 0.0.0.0:8080 -> 8080

Note: --address parameter added

This enables the port to be available for global usage. Open the ip of http://publicip:8080 (after security group rules). This should open Argo Console

Without Specifying the address parameter and using ssh tunnel 

[ec2-user@ip-172-31-41-130 tmp]$ kubectl port-forward svc/argocd-server 8080:443 -n argocd
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
Handling connection for 8080
Handling connection for 8080

ssh -L 8085:127.0.0.1:8080 ec2-user@ec2-54-196-65-147.compute-1.amazonaws.com

Connect to browser using port 8085

http://127.0.0.1:8086/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/

