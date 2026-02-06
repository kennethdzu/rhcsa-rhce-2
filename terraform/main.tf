provider "aws" { region = "af-south-1" }

module "networking" { source = "./modules/networking" }
module "compute" {
  source         = "./modules/compute"
  exam_vpc_id    = module.networking.vpc_id
  exam_subnet_id = module.networking.subnet_id
}

resource "local_file" "inventory" {
  content  = <<EOF
[rhce_nodes]
${module.compute.public_ip}

[lab:children]
rhce_nodes

[lab:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_private_key_file=~/.ssh/Terra.pem
EOF
  filename = "../ansible/inventory/hosts.ini"
}
