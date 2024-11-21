###### Recursos

#Recurso de la instancia en aws "aws_instance"
resource "aws_instance" "nginx-server" {
    ami           = var.ami_id
    instance_type = var.instance_type

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
        Name        = var.server_name
        Environment = var.environment
        Owner = "wizardlyfix@outlook.es"
        Team = "Entrevista"
        Project = "Tarea"
    }
}