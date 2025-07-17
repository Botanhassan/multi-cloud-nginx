provider "aws" {
  region     = var.region

}
# Création de la clé publique SSH sur AWS
resource "aws_key_pair" "deployer_key" {
  key_name   = var.key_name
  public_key = file("id_rsa_github.pub")


}

resource "aws_security_group" "allow_web" {
  name        = "allow_ssh_http_3"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer_key.key_name
  security_groups = [aws_security_group.allow_web.name]

  tags = {
    Name = "nginx-aws"
  }

  provisioner "local-exec" {
  command = <<EOT
echo "[web]" > ../ansible/inventory.ini
echo "${self.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa" >> ../ansible/inventory.ini
EOT
}
}
# Ceci est un test pour relancer le pipeline maintenant
