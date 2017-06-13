
# Cloud environment provision

As a developer on the project,
So that I can test the system,
And get on with adding features,
I need some infrastructure code to provision an
environment on the cloud,
And deploy the microservices,
And configure the system so we can test changes

## Infrastructure provisioning with Terraform in AWS

Instructions to follow in order to provision an ec2 instance where to deploy the services.

1. Install terraform in your machine https://www.terraform.io/intro/getting-started/install.html
2. Create key_pair
3. From the following directory _terraform-ansible-example/infrastructure_ execute terraform commands.
4. Execute terraform command plan to verify that terraform is setup properly and aws environment is well configured.
```
terraform plan -var 'access_key={acces-key}' -var 'secret_key={secret-key} -var 'public_key={public-key}'
```

Variables:
 
- access_key: aws access key.
- secret_key: aws secret key.
- public_key: public key name to authorize ssh in the provisioned instance.

In order to provision the infrastructure:

- Execute terraform apply to provision an ec2 intance by terraform

```
terraform plan -var 'access_key={acces-key}' -var 'secret_key={secret-key}' -var 'public_key={public-key}'
```
At this point we have an ec2 instance provisioned and ready for provisioning the services 

## Instance provisioning and sevices deployment with Ansible

In order to bootstrap the ec2 instance and provision the services we follow the next steps: 

- Install ansible 2.3.0 in your machine by using http://docs.ansible.com/ansible/intro.html
- Install ansible-vault with `pip install ansible-vault`
- Modify file hosts at _terraform-ansible-example/provisioning/ansible/inventories/hosts_ with your ec2 instance details.
- Run ansible script provisioning/ansible folder `ansible-playbook -vvvv --ask-vault-pass -i inventories/hosts ./services-playbook.yml` 

**Notice that you need vault pass to run the playbook -- sending it over by keybase or similar**

## configure the system
        

Acceptance criteria:

- We want to clone the repo, set an API key and
run the code, to have a working environment

- Should include good documentation so we can
run script from one of our dev laptops

Notes on ‘future work’

- In future, we need to extend these scripts via
the CI server to build a deployment pipeline

- We need to add environments and extend and
harden into a production system later on