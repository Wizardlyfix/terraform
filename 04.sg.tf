# Recurso del Security Group
resource "aws_security_group" "nginx-server-sg" {
    name        = "${var.server_name}-sg"
    description = "Security group allowing SSH and HTTP access"

    ingress {
        from_port   = 22 # Puerto solicitado para entrar
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # Para que acepte todo el tráfico
    }

    ingress {
        from_port   = 80 # Puerto solicitado para entrar
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port   = 0 # Significa que acepta todos los puertos de 0 a 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(local.standard_tags, {
        Name        = var.server_name,
        Environment = var.environment
        # Owner = "wizardlyfix@outlook.es"
        # Team = "Entrevista"
        # Project = "Tarea"
    })
}