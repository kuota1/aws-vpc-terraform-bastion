# Generar un sufijo aleatorio para evitar colisiones de nombres
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

# Generar la clave privada SSH
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Crear una Key Pair en AWS con la clave pública
resource "aws_key_pair" "mi_llave" {
  key_name   = "mi-clave-${random_string.suffix.result}"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Guardar la clave privada en un archivo local
resource "local_file" "private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/mi-clave-${random_string.suffix.result}.pem"
}

# Asegurar la clave privada con permisos 400
resource "null_resource" "secure_private_key" {
  depends_on = [local_file.private_key]

  /*provisioner "local-exec" {
    command = "chmod 400 ${local_file.private_key.filename}"
  }*/
}