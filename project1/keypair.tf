# Create Keypair in AWS


resource "aws_key_pair" "key-arthur" {
  key_name   = "${var.owner}-key"
  public_key = tls_private_key.rsa.public_key_openssh
}


# Generate RSA key of size 4096 bits
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "prv_key" {
  content         = tls_private_key.rsa.private_key_pem
  filename        = "tfkey.pem"
  file_permission = 0400
}
