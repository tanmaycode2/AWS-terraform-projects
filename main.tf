provider "aws" {
  region = "us-east-1"  # Modify as needed
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-051f7e7f6c2f40dc1"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "aws-terraform-key"  # Replace with your key pair name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]  # Associate the security group with the instance

  tags = {
    Name = "docker-nginx-instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum install -y docker
              systemctl enable docker
              systemctl start docker
              sudo chown $USER /var/run/docker.sock
              docker run -p 80:80 -d nginx
              EOF
}

resource "aws_security_group" "ec2_sg" {
  name        = "docker-nginx-sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 443
    to_port     = 443
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