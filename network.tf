resource "aws_security_group" "my_server" {
	name        = "SecurityGroupFirst"
	description = "HTTP_AND_SSH"
	
	dynamic "ingress"{
	for_each = ["22", "80"]
	  content {
		from_port   = ingress.value
		to_port     = ingress.value
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	  }
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}