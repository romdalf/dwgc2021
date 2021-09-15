## DeveloperWeek Global Cloud 2021 Conference 

This repository provides the content of an OPEN TALK held at the DeveloperWeek Global Cloud 2021 about *How to solve Kubernetes persistent storage at scale and speed the GitOps way*. 

Persistent storage is one of the most difficult challenges to solve for Kubernetes workloads especially when integrating with continuous deployment solutions. The session will provide the audience with an overview of how to address persistent storage for stateful workload the Kubernetes way and how to operationalize with a common CD practice like GitOps.

The content is for educational purposes, is linked to field experience, and, for the demo, tested on Google Cloud. The content can be reused freely as-is. StorageOS Customer Success is available to provide the audience with the supporting experience in such journey.

## Intro
The last two decades of IT innovations have been addressing the consumption of resources; from an usage and cost efficiency up.  
However, even with the introduction of Agile and DevOps practices leading to an organized, scalable, and systemic automation, the speed of deployment within large enterprise did not improve due to the heavily siloed IT department. 
The below graph presents the actual run time for all related tasks to accomplish versus the lead time which includes the run time AND the SLA driven organization in which multiple team will pass the "ball". This curve is an exponentially increasing with additional third parties like managed services.   

![virtualization stack](assets/virtstack.png)

## Kubernetes
Large software companies with the need of a fast go-to-market had to change their models to guarantee fast development and release cycles.  
With the need of companies like Google, a new approach to efficiency was taken wihtin the form of Kubernetes.  
Why is it different?  
Virtualization stack provisions every components as isolated ones in a serialized way, most likely reflecting the organizational structure and processes of the IT department.  
The major shift here is to: 
- enforce a defacto Infrastructure-as-Code approach defining a desired state for every components 
- enforce a software-define approach allowing to reduce the manual or semi-automated actions to configure hardware components 
- provide a full abstraction layer through the usage of an API driven solution to deal with any components including deploying applications 

When an Application Team has to deploy an application, in any of the DTAP stages, there is no need to create a dozen tickets to a dozen or more teams. Instead, the actual application needs is detailed as a desired state within a YAML file which will be submitted and processed by Kubernetes.  
The run time can become the lead time!

![kubernetes stack](assets/k8sstack.png)

## Stateful applications 
There is a massive secret to be shared regarding Kubernetes; it is designed to run stateless workload or, in other words, applications that don't need persistence of data.  
Kubernetes is an orchestrator for containers and these are based on read-only container images. Any data generated during the run time of the container will be in memory. Once the workload is stop or even rescheduled on a different node, that data will be lost.  
Kubernetes is not a storage orchestrator like it is not a network orchestrator, it relies on software-defined components to handle such requirements.  

Not having such software-defined components to handle the storage part will result in having a hybrid operational model calling for tickets handling for attaching storage to the Kubernetes nodes generating a wait time to associated with the run time as shown with the next graph.

![kubernetes hybrid stack](assets/k8sstacklegstorage.png)

## Stateless/Stateful who cares?
To this shoking question and considering the Kubernetes abstration framework, no one should care!

![kubernetes native stack](assets/k8sstackcnstorage.png)
Let's take a not related example; when a TLS certificate is required for an application, calling a Kubernetes native component like [cert-manager](https://cert-manager.io/docs/) allows the Application Team to self-service the request reducing the lead time for operational readiness with the burden to knwon about the organization current and future choices regarding a certificate provider. 

Let's come back to the stateful application example; when an application need to store and access data, calling a Kubernetes native component to handle persistent volume is mandatory to allow the same frictionless, self-service, and benefiting of all the Kubernetes perks. 

Well guess what... Kubernetes native Software-Defined-Storage exists! And the good thing is that there are no needs to learn any CLI commands, skill up in storage terminology except for capacity and the minimum Kubernetes object definitions, or to perform extensive automation to hook up the old legacy storage to the Kubernetes platform.

## We all agree, we don't care!

But! Alright, as Application Teams, we indeed don't care about all that storage (or snorage for snoring + storage as I have heard it a couple of time). Our Infrastructure/Platform colleagues who knowns about that stuff created for us the 2 or 3 StorageClass:
- storage-for-dev-and-test
- storage-for-acceptance
- storage-for-production

That's it! Well, one more thing, then we will done selling the dreams ;)  
In 99% of cases, when deploying a stateful application, a specific deployment type called ["StatefulSet"](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) (and more [here](https://cloud.google.com/kubernetes-engine/docs/how-to/stateful-apps)) has to be used to "ask" the Kubernetes orchestrator to:
- be gentle! It's not a stateless application. 
- respect the order! With stateful application, order is required for deployment, scaling and updating   

## show me the YAML!

Let's go from the long intro to the demo. 

### StorageClass
What do we need first? Well, as shared earlier, there is a need for StorageClass defining the desired state for a technical and business perspective. The Ops Team might defined the followings:

storage-for-dev-and-test
```YAML
---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: storage-for-dev-and-test
provisioner: csi.storageos.com
allowVolumeExpansion: true
parameters:
  fsType: ext4
  pool: default
  csi.storage.k8s.io/controller-expand-secret-name: csi-controller-expand-secret
  csi.storage.k8s.io/controller-publish-secret-name: csi-controller-publish-secret
  csi.storage.k8s.io/node-publish-secret-name: csi-node-publish-secret
  csi.storage.k8s.io/provisioner-secret-name: csi-provisioner-secret
  csi.storage.k8s.io/controller-expand-secret-namespace: kube-system
  csi.storage.k8s.io/controller-publish-secret-namespace: kube-system
  csi.storage.k8s.io/node-publish-secret-namespace: kube-system
  csi.storage.k8s.io/provisioner-secret-namespace: kube-system
```

storage-for-acceptance
```YAML
---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: storage-for-acceptance
provisioner: csi.storageos.com
allowVolumeExpansion: true
parameters:
  fsType: ext4
  pool: default
  storageos.com/replicas: "1"
  csi.storage.k8s.io/controller-expand-secret-name: csi-controller-expand-secret
  csi.storage.k8s.io/controller-publish-secret-name: csi-controller-publish-secret
  csi.storage.k8s.io/node-publish-secret-name: csi-node-publish-secret
  csi.storage.k8s.io/provisioner-secret-name: csi-provisioner-secret
  csi.storage.k8s.io/controller-expand-secret-namespace: kube-system
  csi.storage.k8s.io/controller-publish-secret-namespace: kube-system
  csi.storage.k8s.io/node-publish-secret-namespace: kube-system
  csi.storage.k8s.io/provisioner-secret-namespace: kube-system
```

storage-for-production
```YAML
---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: storage-for-production
provisioner: csi.storageos.com
allowVolumeExpansion: true
parameters:
  fsType: ext4
  pool: default
  storageos.com/replicas: "2"
  storageos.com/encryption: "true"
  csi.storage.k8s.io/controller-expand-secret-name: csi-controller-expand-secret
  csi.storage.k8s.io/controller-publish-secret-name: csi-controller-publish-secret
  csi.storage.k8s.io/node-publish-secret-name: csi-node-publish-secret
  csi.storage.k8s.io/provisioner-secret-name: csi-provisioner-secret
  csi.storage.k8s.io/controller-expand-secret-namespace: kube-system
  csi.storage.k8s.io/controller-publish-secret-namespace: kube-system
  csi.storage.k8s.io/node-publish-secret-namespace: kube-system
  csi.storage.k8s.io/provisioner-secret-namespace: kube-system
```

### StatefulSet 

Alright, now that we have our StorageClass being defined, let's have a look at the actual definition to deploy a PostgreSQL database for an online food magazine: 

```YAML
---
apiVersion: v1
kind: Service
metadata:
  name: foodmag-app-db-service
  namespace: stateful-app-dev
  labels:
    app: foodmag-app-db
    env: dev
spec:
  type: ClusterIP
  ports:
   - port: 5432
  selector:
    app: foodmag-app-db
    env: dev
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: foodmag-app-db
  namespace: stateful-app-dev
spec:
  selector:
    matchLabels:
      app: foodmag-app-db
      env: dev
  serviceName: foodmag-app-db-service
  replicas: 1
  template:
    metadata:
      annotations:
        backup.velero.io/backup-volumes: foodmag-app-db-pvc
      labels:
        app: foodmag-app-db
        env: dev
    spec:
      containers:
        - name: foodmag-app-db
          image: postgres:latest
          ports:
            - containerPort: 5432
              name: foodmag-app-db
          env:
            - name: POSTGRES_DB
              value: foodmagappdb
            - name: POSTGRES_USER
              value: foodmagapp
            - name: POSTGRES_PASSWORD
              value: foodmagpassword
            - name: PGDATA
              value: /var/lib/postgresql/data/pgdata
          volumeMounts:
            - name: foodmag-app-db-pvc
              mountPath: /var/lib/postgresql/data
  volumeClaimTemplates:
    - metadata:
        name: foodmag-app-db-pvc
        labels:
          app: foodmag-app-db
          env: dev
      spec:
        accessModes: ["ReadWriteOnce"]
        storageClassName: "storage-for-dev-and-test"
        resources:
          requests:
            storage: 10Gi
```

L33t! What about the front-end? Being quite of old school, let's use Drupal which is a perfect example of a very *picky* application when it comes to data hierarchy for the multi-tenancy/multi-site feature. Here is the StatefulSet:

```YAML
---
apiVersion: v1
kind: Service
metadata:
  name: foodmag-app-fe-service
  namespace: stateful-app-dev
  labels:
    app: foodmag-app-fe
    env: dev
spec:
  type: NodePort
  ports:
   - port: 80
     nodePort: 30080
  selector:
    app: foodmag-app-fe
    env: dev
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: foodmag-app-fe
  namespace: stateful-app-dev
spec:
  selector:
    matchLabels:
      app: foodmag-app-fe
      env: dev
  serviceName: foodmag-app-fe-service
  replicas: 1
  template:
    metadata:
      annotations:
        backup.velero.io/backup-volumes: foodmag-app-fe-pvc            
      labels:
        app: foodmag-app-fe
        env: dev
    spec:
      initContainers:
        - name: fix-perms
          image: drupal:latest
          command: ['/bin/bash','-c']
          args: ['/bin/cp -R /var/www/html/sites/ /data/; chown -R www-data:www-data /data/']
          volumeMounts:
            - name: foodmag-app-fe-pvc
              mountPath: /data
      containers:
        - name: foodmag-app-fe
          image: drupal:latest
          ports:
            - containerPort: 30080
              name: foodmag-app-fe
          volumeMounts:
            - name: foodmag-app-fe-pvc
              mountPath: /var/www/html/modules
              subPath: modules
            - name: foodmag-app-fe-pvc
              mountPath: /var/www/html/profiles
              subPath: profiles
            - name: foodmag-app-fe-pvc
              mountPath: /var/www/html/themes
              subPath: themes
            - name: foodmag-app-fe-pvc
              mountPath: /var/www/html/sites
              subPath: sites
  volumeClaimTemplates:
    - metadata:
        name: foodmag-app-fe-pvc
        labels:
          app: foodmag-app-fe
          env: dev
      spec:
        accessModes: ["ReadWriteOnce"]
        storageClassName: "storage-for-dev-and-test"
        resources:
          requests:
            storage: 10Gi
```

