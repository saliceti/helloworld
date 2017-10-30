## 2 tier Hello world

Complete cloud infrastructure and configuration management to deploy a hello world application.

### Application

Written in golang and packaged as a Docker image. It is deployed on Ubuntu servers
running Docker.
Can be scaled horizontally.

### Load balancing

Performed by Nginx. Requests received by Nginx are proxied to the app servers in
a round robin fashion.

### Cloud infrastructure

Based on AWS, using default VPC, default subnet and VMs with Public IP. Basic security
is achieved by locked down security groups and SSH connections.

### Requirements

* AWS credentials with full EC2 permissions. `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
should be available as environment variables
* Docker Hub account, already logged in locally. `HUB_ACCOUNT` should point to your
hub account name.
* Docker Hub repository called `hello-world` in your account
* Local Docker engine (tested with version 17.09.0-ce)
* Terraform (tested with version 0.10.6)
* Python, ideally in a virtualenv

### Full deploy

```bash
$ export AWS_ACCESS_KEY_ID=...
$ export AWS_SECRET_ACCESS_KEY=...
$ export HUB_ACCOUNT=...
$ make
```

### Other useful commands

Other make commands exist to run specific parts of the infrastructure. Explore the Makefile
to find them.

### Caveats

* Terraform state is not stored remotely
* The web tier is not highly available
* Using ELBs and more Docker could remove the need for Ansible
* VMs use public IPs. This could be made more secure with dedicated subnet, NAT gateway, bastion...
* The app deploy is very basic and involves a little downtime (in seconds)
* There is an issue with the Nginx playbook. A workaround exists but this may force to run Ansible twice
