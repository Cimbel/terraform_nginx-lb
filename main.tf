provider "aws" {}

resource "aws_instance" "MyLinux1"{
	ami           	       = "ami-089c6f2e3866f0f14" 
	instance_type 	       = "t2.micro"
	vpc_security_group_ids = [aws_security_group.my_server.id]
	user_data 	           = file("user_data_apache1.sh")
	key_name	           = aws_key_pair.new_key.key_name
	tags                   = {Name = "Web-Server-Apache-1"}
}

resource "aws_instance" "MyLinux2"{
	ami                    = "ami-089c6f2e3866f0f14"
	instance_type          = "t2.micro"
	vpc_security_group_ids = [aws_security_group.my_server.id]
	user_data 	           = file("user_data_apache2.sh")
	key_name               = aws_key_pair.new_key.key_name
	tags 		           = {Name = "Web-Server-Apache-2"}
}

resource "aws_instance" "MyLinuxNginx"{
	ami                    = "ami-089c6f2e3866f0f14"
	instance_type          = "t2.micro"
	vpc_security_group_ids = [aws_security_group.my_server.id]
	user_data              = templatefile("user_data_nginx.sh.tpl", {
	    web_server_ip_1 = aws_instance.MyLinux1.public_ip,
	    web_server_ip_2 = aws_instance.MyLinux2.public_ip
	})
	key_name               = aws_key_pair.new_key.key_name
	tags                   = {Name = "Web-Server-Nginx"}
	depends_on             = [aws_instance.MyLinux1, aws_instance.MyLinux2]
	
	provisioner "local-exec"{
		command = "echo Web-Server-1_public_ip:${aws_instance.MyLinux1.public_ip} > ./ip_addresses.txt"
	}
	
	provisioner "local-exec" {
		command = "echo Web-Server-2_public_ip:${aws_instance.MyLinux2.public_ip} >> ./ip_addresses.txt"
	}
	
	provisioner "local-exec"{
		command = "echo Web-Server-Nginx-As-LB_public_ip:${aws_instance.MyLinuxNginx.public_ip} >> ./ip_addresses.txt"
	}
}
