# terraform init - Para inicializar un directorio de terraform - se comunica con los proveedores y configura el backend
# terraform plan - Para generar un plan de ejecución
# terraform apply - Para aplicar los cambios
# terraform destroy - Para destruir los recursos


####### Archivo de estado almacenado en S3 Bucket

terraform {
  backend "s3" {
    bucket = "tfstate-work-1238fdf874"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}

####### Proveedor

provider "aws" {
  region = "us-east-1"
}

###### Recursos

#Recurso de la instancia en aws "aws_instance"
resource "aws_instance" "nginx-server" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t3.micro"

  user_data = <<-EOF
              #!/bin/bash 
              sudo yum install -y nginx      #instalar nginx
              sudo systemctl enable nginx    #habilitar el servicio nginx
              sudo systemctl start nginx     #iniciar el servicio nginx
              EOF
  
  key_name = aws_key_pair.nginx-server-ssh.key_name  #conectar el recurso aws_key_pair con esta instancia
  #Asignar el Security Group a la instancia
  vpc_security_group_ids = [aws_security_group.nginx-server-sg.id] #La propiedad id está importada en terraform y no importa

  #Agregar los tags
  tags = {
    Name = "nginx-server"
    Environment = "test"
    Owner = "wizardlyfix@outlook.es"
    Team = "Entrevista"
    Project = "Tarea"
  }
}

# Recurso de la clave ssh en aws "aws_key_pair"

# ssh-keygen -t rsa -b 2048 -f "nginx-server.key"
resource "aws_key_pair" "nginx-server-ssh" {
  key_name = "nginx-server-ssh"
  public_key = file("nginx-server.key.pub")

  tags = {
    Name = "nginx-server-ssh"
    Environment = "test"
    Owner = "wizardlyfix@outlook.es"
    Team = "Entrevista"
    Project = "Tarea"
  }
}

# Recurso del Security Group
resource "aws_security_group" "nginx-server-sg" {
  name        = "nginx-server-sg"
  description = "Security group allowing SSH and HTTP access"

  ingress {
    from_port   = 22 #Puerto solicitado para entrar
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Para que acepte todo el tráfico
  }

  ingress {
    from_port   = 80 #Puerto solicitado para entrar
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port        = 0 #Significa que acepta todos los puertos de 0 a 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-server-sg"
    Environment = "test"
    Owner = "wizardlyfix@outlook.es"
    Team = "Entrevista"
    Project = "Tarea"
  }
}

output "public_ip" {
  description = "Dirección IP pública de la instancia EC2"
  value = aws_instance.nginx-server.public_ip
}

output "server_public_dns" {
  description = "DNS público de la instancia EC2"
  value = aws_instance.nginx-server.public_dns
}

#terraform output:

# curl http://52.90.248.59

#Para conectarse por SSH:

# ssh ec2-user@52.90.248.59 -i ./nginx-server.key
