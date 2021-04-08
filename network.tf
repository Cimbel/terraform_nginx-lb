resource "aws_security_group" "my_server" {
	name        = "SecurityGroupFirst"
	description = "HTTP_AND_SSH"
	
	dynamic "ingress"{
	for_each = var.allow_ports
	  content {
		from_port   = ingress.value
		to_port     = ingress.value
		protocol    = "tcp"
		cidr_blocks = var.cidr_block
	  }
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = merge(var.common_tags, {Name = "SecurityGroup_BigBubble"})
}