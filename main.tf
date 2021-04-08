provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

locals {
  apache1 = "user_data_apache1.sh"
  apache2 = "user_data_apache2.sh"
  nginx1  = "user_data_nginx.sh.tpl"
}

resource "aws_instance" "MyLinux1" {
  ami                    = data.aws_ami.amazon_linux_ami.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_server.id]
  user_data              = file(local.apache1)
  key_name               = aws_key_pair.new_key.key_name
  tags                   = merge(var.common_tags, { Name = "Web-Server-Apache-1" })
}

resource "aws_instance" "MyLinux2" {
  ami                    = data.aws_ami.amazon_linux_ami.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_server.id]
  user_data              = file(local.apache2)
  key_name               = aws_key_pair.new_key.key_name
  tags                   = merge(var.common_tags, { Name = "Web-Server-Apache-2" })
}

resource "aws_instance" "MyLinuxNginx" {
  ami                    = data.aws_ami.amazon_linux_ami.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_server.id]
  user_data = templatefile(local.nginx1, {
    web_server_ip_1 = aws_instance.MyLinux1.public_ip,
    web_server_ip_2 = aws_instance.MyLinux2.public_ip
  })
  key_name   = aws_key_pair.new_key.key_name
  tags       = merge(var.common_tags, { Name = "Web-Server-Nginx" })
  depends_on = [aws_instance.MyLinux1, aws_instance.MyLinux2]

  provisioner "local-exec" {
    command = "echo Web-Server-1_public_ip:${aws_instance.MyLinux1.public_ip} > ./ip_addresses.txt"
  }

  provisioner "local-exec" {
    command = "echo Web-Server-1_public_ip:${aws_instance.MyLinux2.public_ip} >> ./ip_addresses.txt"
  }

  provisioner "local-exec" {
    command = "echo Web-Server-1_public_ip:${aws_instance.MyLinuxNginx.public_ip} >> ./ip_addresses.txt"
  }
}
