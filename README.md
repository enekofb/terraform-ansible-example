
#Cloud environment provision

As a developer on the project,
So that I can test the system,
And get on with adding features,
I need some infrastructure code to provision an
environment on the cloud,
And deploy the microservices,
And configure the system so we can test changes

## provision environment on the cloud

eneko@eneko-XPS-15-9550:~/opencredo/projects/eneko/terraform-ansible-example/infrastructure$ terraform apply -var 'access_key={acces-key}' -var 'secret_key='

## deploy microservices

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