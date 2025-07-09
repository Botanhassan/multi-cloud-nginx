# HEAD
# multi-cloud-nginx

# Multi-Cloud NGINX Deployment

Ce projet déploie un serveur NGINX sur AWS via Terraform et configure automatiquement le serveur avec Ansible.

## Structure du projet

- `terraform-aws/` : fichiers Terraform pour provisionner l'instance EC2
- `ansible/` : playbook pour installer et configurer NGINX
- `.github/workflows/` : pipeline GitHub Actions pour tout automatiser

## Déploiement automatique

Pousser sur `main` déclenchera automatiquement :
- `terraform init`, `plan`, `apply`
- L'exécution d'Ansible
# a2b0abb (Premier commit : infra Terraform + Ansible)
