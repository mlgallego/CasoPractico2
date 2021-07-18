#!/bin/bash
ansible-playbook -i hosts setup.yaml
ansible-playbook -i hosts start_nfs.yaml
ansible-playbook -i hosts start_kube.yaml
ansible-playbook -i hosts deploy_first_app.yaml
