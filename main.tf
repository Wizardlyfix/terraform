# terraform init - Para inicializar un directorio de terraform - se comunica con los proveedores y configura el backend
# terraform plan - Para generar un plan de ejecución
# terraform apply - Para aplicar los cambios
# terraform destroy - Para destruir los recursos


### Standard Tags

locals {
  standard_tags = {
    Owner = "wizardlyfix@outlook.es"
    Team = "Entrevista"
    Project = "Tarea"
  }
}

####### Archivo de estado almacenado en S3 Bucket

terraform {
  backend "s3" {
    bucket = "tfstate-work-1238fdf874"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}

#terraform output:

# curl http://52.90.248.59

#Para conectarse por SSH:

# ssh ec2-user@52.90.248.59 -i ./nginx-server.key

#Para generar la clave ssh:

# ssh-keygen -t rsa -b 2048 -f "nginx-server.key"

