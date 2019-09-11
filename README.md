# boot-to-cloud

Create a quick virtual instance to offload tasks, that can be quickly destroyed.

## Requirements

- terraform
- ansible
- ansible galaxy
- ssh keys
- aws cli (not actually used but terraform uses it's authentication details)

## Creation

Modify the VM you'd like to make using the variables.tf file.

Modify the software you'd like to install by modifying the ansible playbook 'development.yml'. Roles from Ansible Galaxy can be used by adding them to requirements.yml

When ready, `terraform apply` to create the instance. If you'd like to modify the configuration in runtime, use ansible.

## Connection

`connect.sh` will start a ssh connection to your machine.

All egress traffic is permitted, SSH & HTTP/S is allowed in.

## Cremation

`terraform destroy` will anhilate all your resources and clean up after yourself. Thanks terraform!

(you are responsible for checking the AWS console for any dangling resources. I accpet no responsibility for any charges incurred.)