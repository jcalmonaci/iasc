#Asignacion del proveedor a conectar
provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = "us-east-1"
}

#Abrir una terminal y ejecutar "terraform init" para inicializar terraform

#Generar una instancia en AWS
resource "aws_instance" "Reverse-Proxy" {
  instance_type          = "t2.micro"              #Seleccionar instanacia gratuita
  ami                    = "ami-08d4ac5b634553e16" #Se obtiene en la pagina de AWS en el apartado de LANZAR INSTANCIA
  key_name               = "MRSI"
  user_data              = filebase64("${path.module}/scripts/docker.sh")
  vpc_security_group_ids = [aws_security_group.WbSG.id]
}

resource "aws_security_group" "WbSG" {
  name = "sg_reglas_firewall"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "SG HHTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "SG HHTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "SG SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "SG All Traffic Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

  }
  
  
  
  #En terminal ejecutar "terraform fmt" para darle formato al archivo
  #Ejecutar en terminal "terraform plan" para planificacion
  #Ejecutar en terminal "terraform apply --auto-approve" para ejecutar
  #Ejecutar en terminal "terraform destroy --auto-approve" para eliminar 
}
output "public_ip" {
  value="${join(",", aws_instance.Reverse-Proxy.*.public_ip)}" #Obtener la IP Publica de la instancia creadada 
}

