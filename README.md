## DeveloperWeek Global Cloud Conference 

This repository provides the content of an OPEN TALK held at the DeveloperWeek Global Cloud 2021 about how to solve Kubernetes persistent storage at scale and speed the GitOps way. 

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

Once onboarded on the Kubernetes platform, the above example will not take weeks or days, but a couple of minutes. 

## 
