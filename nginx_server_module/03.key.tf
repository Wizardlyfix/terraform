# Recurso de la clave ssh en aws "aws_key_pair"

# ssh-keygen -t rsa -b 2048 -f "nginx-server.key"
resource "aws_key_pair" "nginx-server-ssh" {
    key_name = "${var.server_name}-ssh"
    public_key = file("${var.server_name}.key.pub")

    tags = {
        Name        = var.server_name
        Environment = var.environment
        Owner = "wizardlyfix@outlook.es"
        Team = "Entrevista"
        Project = "Tarea"
    }
}