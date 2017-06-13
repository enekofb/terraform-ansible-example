# Cloud environment provision

- Based on the following story we are going to provision an AWS ec2 instances using Terraform and Ansible 

```
As a developer on the project,
So that I can test the system,
And get on with adding features,
I need some infrastructure code to provision an
environment on the cloud,
And deploy the microservices,
And configure the system so we can test changes
```

## Requirements

1. AWS cli installed and configured: http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

```
cat ~/.aws/config 
[default]
region = eu-west-1
output = json

cat ~/.aws/credentials 

[default]
aws_secret_access_key = xxxx
aws_access_key_id = xxxxx
eneko@eneko-XPS-15-9550:~/opencredo/projects/eneko/terraform-ansible-example/infrastructure$ 

```

2. Install terraform in your machine https://www.terraform.io/intro/getting-started/install.html
3. Install ansible 2.3.0 in your machine by using http://docs.ansible.com/ansible/intro.html and ansible-vault to manage secrets
   Install ansible-vault with `pip install ansible-vault`


## Infrastructure provisioning with Terraform in AWS

Instructions to follow in order to provision an ec2 instance where to deploy the services.

1. From the following directory _terraform-ansible-example/infrastructure_ execute terraform commands.
2. Execute terraform command plan to verify that terraform is setup properly and aws environment is well configured.
```
terraform plan -var 'public_key={public-key}'
```

Variables:
 
- public_key: public key name to authorize ssh in the provisioned instance.

In order to provision the infrastructure:

- Execute terraform apply to provision an ec2 intance by terraform

```
terraform plan -var 'public_key={public-key}'
```
At this point we have an ec2 instance provisioned and ready for provisioning the services 

## Instance provisioning and sevices deployment with Ansible

In order to bootstrap the ec2 instance and provision the services we follow the next steps: 

- Do not need to specify your inventory so its using ansible aws dynamic inventory (using aws default config).
- Run ansible script provisioning/ansible folder ` ansible-playbook -vvvv --ask-vault-pass -u centos -i inventories/external ./services-playbook.yml` 

**Notice that you need vault pass to run the playbook -- sending it over by keybase or similar**

## configure the system

- If you want to change any of the environment variables you just need to modify it the section vars
for the playbook at `terraform-ansible-example/provisioning/ansible/services-playbook.yml`

```
  vars:
  - frontend_app_port: 8080
  - newsfeed_app_port: 8081
  - quotes_app_port: 8082
  - static_content_port: '8000'
  - static_content_url: 'http://localhost:{{static_content_port}}'
  - frontend_service_url: 'http://localhost:{{frontend_app_port}}'
  - newsfeed_service_url: 'http://localhost:{{newsfeed_app_port}}'
  - quotes_service_url: 'http://localhost:{{quotes_app_port}}'

```
        

## Notes on ‘future work’

### In future, we need to extend these scripts via the CI server to build a deployment pipeline

This solution integrates without problems with deployment pipelines so has two independent steps (provisioning infrastructure and provisioning services).

###  We need to add environments and extend and harden into a production system later on
- Do we want to use different environments in Terraform --> use different vars files with the configuration related to the environment
and keep the state files per environment
- Do we want to provision different environments with Ansible --> use different dynamic inventories (ini files) per staging 