output "public_ip_instance_MyLinux1" {
  value = aws_instance.MyLinux1.public_ip
}

output "public_ip_instance_MyLinux2" {
  value = aws_instance.MyLinux2.public_ip
}

output "public_ip_instance_MyLinuxNginx" {
  value = aws_instance.MyLinuxNginx.public_ip
}

output "aws_amazon_linux_ami_id" {
  value = data.aws_ami.amazon_linux_ami.id
}

output "aws_amazon_linux_name" {
  value = data.aws_ami.amazon_linux_ami.name
}
