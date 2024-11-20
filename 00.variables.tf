####### Variables de entorno #######

variable "ami_id" {
    description = "ID de la AMI para la instancia de EC2"
    default = "ami-0440d3b780d96b29d"
}

variable "instance_type" {
    description = "Tipo de instancia de EC2"
    default = "t3.micro"
}

variable "server_name" {
    description = "Nombre del servidor web"
    default = "nginx-server"
}

variable "environment" {
    description = "Ambiente de la aplicación"
    default = "test"
}
