resource "aws_network_interface" "main" {
  subnet_id = var.subnet_id
  private_ips = [var.nginx_private_ip]
  security_groups = [aws_security_group.sg-nginx-server.id] 
  tags = {
    "Name" = "IP address private"
  }
  
}

resource "aws_instance" "main" {
  ami           = var.ami
  instance_type = var.instance_type_nginx
 # key_name	= var.keyname_nginx
  network_interface {
     network_interface_id = "${aws_network_interface.main.id}"
     device_index = 0
  }
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 125
    encrypted = true
    delete_on_termination = false

    tags = {
        "Name" = "nginx-server-${var.env}"
        "Environment" = var.env
        }
  }

    user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

}


resource "aws_security_group" "sg-nginx-server" {
  description = "security group for nginx-server-${var.env}"
  name_prefix = "SG-nginx-server-${var.env}"
  vpc_id      = var.vpc_id

tags = {
    Name = "SG-nginx-server-${var.env}"
  }

}


resource "aws_security_group_rule" "allow_nginx_port" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "VPC CIDR"

  security_group_id = aws_security_group.sg-nginx-server.id
}



resource "aws_security_group_rule" "allow_nginx_port_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "OpenVPN Server"

  security_group_id = aws_security_group.sg-nginx-server.id
}

resource "aws_security_group_rule" "allow_port_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Internet Outbound"

  security_group_id = aws_security_group.sg-nginx-server.id
}
