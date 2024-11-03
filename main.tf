# terraform init - Para inicializar un directorio de terraform
# terraform plan - Para generar un plan de ejecución
# terraform apply - Para aplicar los cambios
# terraform destroy - Para destruir los recursos

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
  #Asignar el Secutiry Group a la instancia
  vpc_security_group_ids = [aws_security_group.nginx-server-sg.id] #La propiedad id está importada en terraform y no importa
}

# Recurso de la clave ssh en aws "aws_key_pair"
resource "aws_key_pair" "nginx-server-ssh" {
  key_name = "nginx-server-ssh"
  public_key = file("nginx-server.key.pub")
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
}
