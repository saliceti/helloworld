all: keygen terraform-apply sleep docker-update ansible-playbook

keygen:
	@mkdir -p .ssh
	@[ -f .ssh/ansible ] || ssh-keygen -f .ssh/ansible -N ""

terraform-init:
	terraform init terraform

terraform-plan: terraform-init
	terraform plan -var-file=terraform/terraform.tfvars terraform

terraform-apply: terraform-init
	terraform apply -var-file=terraform/terraform.tfvars terraform

sleep:
	sleep 60

terraform-destroy: terraform-init
	terraform destroy -var-file=terraform/terraform.tfvars terraform

ansible-galaxy:
	ansible-galaxy install -p ansible/roles -r ansible/requirements.yml

ansible-playbook: ansible-galaxy
	cd ansible && \
		EC2_INI_PATH=ec2.ini ansible-playbook -i ec2.py --private-key ../.ssh/ansible -u ubuntu main.yml

docker-update:
	cd app && docker build -t ${HUB_ACCOUNT}/hello-world .
	docker push ${HUB_ACCOUNT}/hello-world
