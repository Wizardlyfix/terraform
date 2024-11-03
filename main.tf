# terraform init - Para inicializar un directorio de terraform
# terraform plan - Para generar un plan de ejecución
# terraform apply - Para aplicar los cambios
# terraform destroy - Para destruir los recursos

# Provider

provider "aws" {
  region = "us-east-1"
}

# Resource

resource "aws_instance" "example" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t3.micro"
}

