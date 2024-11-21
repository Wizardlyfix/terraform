# terraform init - Para inicializar un directorio de terraform - se comunica con los proveedores y configura el backend
# terraform plan - Para generar un plan de ejecución
# terraform apply - Para aplicar los cambios
# terraform destroy - Para destruir los recursos


### Standard Tags

# locals {
#   standard_tags = {
#     Owner = "wizardlyfix@outlook.es"
#     Team = "Entrevista"
#     Project = "Tarea"
#   }
# }

####### Archivo de estado almacenado en S3 Bucket

terraform {
  backend "s3" {
    bucket = "tfstate-work-fgwgn48w9gv"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}

#### Modulos ####

# Modulo nginx_server_dev

module "nginx_server_dev" {
  source = "./nginx_server_module"
  ami_id = "ami-0440d3b780d96b29d"
  instance_type = "t3.medium"
  server_name = "nginx-server-dev"
  environment = "dev"
}

# Modulo nginx_server_qa

module "nginx_server_qa" {
  source = "./nginx_server_module"
  ami_id = "ami-0440d3b780d96b29d"
  instance_type = "t3.small"
  server_name = "nginx-server-qa"
  environment = "qa"
}

# Output para nginx_server_dev

output "nginx_dev_ip" {
    description = "Dirección IP pública de la instancia EC2"
    value = module.nginx_server_dev.server_public_ip
}

output "nginx_dev_dns" {
    description = "DNS público de la instancia EC2"
    value = module.nginx_server_dev.server_public_dns
}

# Output para nginx_server_qa

output "nginx_qa_ip" {
    description = "Dirección IP pública de la instancia EC2"
    value = module.nginx_server_qa.server_public_ip
}

output "nginx_qa_dns" {
    description = "DNS público de la instancia EC2"
    value = module.nginx_server_qa.server_public_dns
}


#terraform output:

# curl http://52.90.248.59

#Para conectarse por SSH:

# ssh ec2-user@52.90.248.59 -i ./nginx-server.key

#Para generar la clave ssh:

# ssh-keygen -t rsa -b 2048 -f "nginx-server.key"

