
# Cloud environment provision

As a developer on the project,
So that I can test the system,
And get on with adding features,
I need some infrastructure code to provision an
environment on the cloud,
And deploy the microservices,
And configure the system so we can test changes

## Infrastructure provisioning with Terraform

- Install terraform in your machine https://www.terraform.io/intro/getting-started/install.html
- Modify your key-pair name need to specify your key pair for the ec2 to create
- From the following directory _terraform-ansible-example/infrastructure_ execute terraform commands
- Execute terraform command plan to verify that terraform is setup properly and aws envrionment is well configures.
```
terraform plan -var 'access_key={acces-key}' -var 'secret_key={secret-key} -var 'key_name={key-name}'
```
- Execute terraform appy to provision an ec2 intance by terraform
```
terraform plan -var 'access_key={acces-key}' -var 'secret_key={secret-key}' -var 'key_name={key-name}'
```

## Instance provisioning and sevices deployment with Ansible

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