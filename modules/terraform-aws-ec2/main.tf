resource "aws_security_group" "ec2_sg" {
  name        = "ec2-http-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = var.vpc_id 

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 8080
    to_port     = 8080
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

resource "aws_instance" "public_instances" {
  count         = var.public_instance
  ami           = "ami-0e35ddab05955cf57"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_ids[count.index]
  associate_public_ip_address = true
  security_groups = [aws_security_group.ec2_sg.id]
 # user_data = local.user_data_files[0]
#   user_data = <<-EOF
#               #!/bin/bash
#               sudo apt-get update -y
#               sudo apt-get install docker.io -y
#               systemctl start docker
#               systemctl enable docker
#               sleep 10
#               docker run -d -p 80:80 -e OPENPROJECT_SECRET_KEY_BASE=secret -e OPENPROJECT_HOST__NAME=0.0.0.0:80 -e OPENPROJECT_HTTPS=false openproject/community:12
#               EOF
  tags = {
    Name = "Public-Instance-${count.index}"
  }
}

