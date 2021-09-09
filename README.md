## DeveloperWeek Global Cloud 2021 Conference 

This repository provides the content of an OPEN TALK held at the DeveloperWeek Global Cloud 2021 about *How to solve Kubernetes persistent storage at scale and speed the GitOps way*. 

Persistent storage is one of the most difficult challenges to solve for Kubernetes workloads especially when integrating with continuous deployment solutions. The session will provide the audience with an overview of how to address persistent storage for stateful workload the Kubernetes way and how to operationalize with a common CD practice like GitOps.

The content is for educational purposes, is linked to field experience, and, for the demo, tested on Google Cloud. The content can be reused freely as-is. StorageOS Customer Success is available to provide the audience with the supporting experience in such journey.

## Intro
Moving from a traditional infrastructure to a Kubernetes platform offers a great amount of flexibility and reduced friction in regards of consuming the actual infrastructure resources. 

Speaking of traditional or legacy infrastructure, when working at the large Public Insistution, an Application Team who would request an test environment would results in: 
- meeting with Project and Release Manager
- meeting with IT Service Manager
- Change Request with the following tickets:
  - 3 to 5 tickets for the Network team (IP, DNS, Load Balancer, Firewall, Proxy, ...)
  - 1 to 5 tickets for the Compute team (depending on the number of machines, OS type, patching policy, ...)
  - 1 to 5 tickets for the Backup & Storage team (storage space, backup, mirror, special scheduling, special retention, ...)
  - 1 to 5 tickets for the Backup team for the Application backup 
  - 1 to 3 tickets for the Security team (Compliance, IAM, scan, ...)

At the end of this "journey", without any automation, at best 4 to 6 weeks would have passed, about 2 with a certain degree of automation. 
Guess what... at this stage, there is not yet an application being deployed or a connection to a clustered DB within the organization! 

Considering the above within a large organization like Google, no wonder why they kicked off a project like Kubernetes to build a full infrastructure and dependency abstraction framework to shortcut the lead time and SLA driven teams. 

Once onboarded on the Kubernetes platform, the above example will not take weeks or days, but a couple of minutes on your own using a declarative configuration file describing a desired state. 

But is true for any type of workload aka the stateful application? 

## Stateless/Stateful who cares?

To this shoking question and considering the Kubernetes abstration framework, no one should care!

Let's take a not related example; when a TLS certificate is required for an application, calling a Kubernetes native component like [cert-manager](https://cert-manager.io/docs/) allows the Application Team to self-service the request reducing the lead time for operational readiness with the burden to knwon about the organization current and future choices regarding a certificate provider. 

Let's come back to the stateful application example; when an application need to store and access data, calling a Kubernetes native component to handle persistent volume is mandatory to allow the same frictionless, self-service, and benefiting of all the Kubernetes perks. 

Well guess what... Kubernetes native Software-Defined-Storage exists! And the good thing is that there are no needs to learn any CLI commands, skill up in storage terminology except for capacity and the minimum Kubernetes object definitions, or to perform extensive automation to hook up the old legacy storage to the Kubernetes platform.

## We all agree, we don't care!

But! Alright, as Application Teams, we indeed don't care about all that storage (or snorage for snoring + storage as I have heard it a couple of time). Our Infrastructure/Platform colleagues who knowns about that stuff created for us the 2 or 3 StorageClass:
- storage-for-dev-and-test
- storage-for-acceptance
- storage-for-production

That's it! Well, one more thing, then we will done selling the dreams ;)  
In 99% of cases, when deploying a stateful application, a specific deployment type called ["StatefulSet"](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) has to be used to "ask" the Kubernetes orchestrator to:
- be gentle! It's not a stateless application. 
- respect the order! With stateful application, order is required for deployment, scaling and updating   




