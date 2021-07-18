#!/bin/bash
ansible-playbook -i hosts.azure setup.yaml
ansible-playbook -i hosts.azure start_nfs.yaml
ansible-playbook -i hosts.azure start_kube.yaml
ansible-playbook -i hosts.azure deploy_first_app.yaml
