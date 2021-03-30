output "public_ip_instance_MyLinux1" {
	value       = aws_instance.MyLinux1.public_ip 
}

output "public_ip_instance_MyLinux2" {
	value       = aws_instance.MyLinux2.public_ip 
}

output "public_ip_instance_MyLinuxNginx" {
	value = aws_instance.MyLinuxNginx.public_ip
}