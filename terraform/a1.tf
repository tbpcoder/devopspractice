provider "aws" {
  region = "us-east-1"
}

# vpc
resource "aws_vpc" "nginx_server_vpc" {
  cidr_block = "10.69.0.0/16"

  tags = {
    Name="nginx_vpc"
  }
}

# subnet
resource "aws_subnet" "nginx_server_subnet" {
  vpc_id = aws_vpc.nginx_server_vpc.id
  cidr_block = "10.69.1.0/24"
  
  tags = {
    Name = "nginx_subnet"
  }
}

# internet gateway
resource "aws_internet_gateway" "nginx_igw" {
  vpc_id = aws_vpc.nginx_server_vpc.id

  tags = {
    Name = "nginx_igw"
  }
}

# route table
resource "aws_route_table" "nginx_route_table" {
  vpc_id = aws_vpc.nginx_server_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nginx_igw.id
  }

  tags = {
    Name = "nginx_route_table"
  }
}

# route table association
resource "aws_route_table_association" "nginx_route_table_association" {
  subnet_id      = aws_subnet.nginx_server_subnet.id
  route_table_id = aws_route_table.nginx_route_table.id
}

# security group
resource "aws_security_group" "nginx_sg" {
  vpc_id = aws_vpc.nginx_server_vpc.id

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

  tags = {
    Name = "nginx_sg"
  }
}

# ami lookup
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# ec2 instance
resource "aws_instance" "nginx_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.nginx_server_subnet.id
  associate_public_ip_address = true
  user_data     = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install -y nginx
                sudo systemctl start nginx
                sudo systemctl enable nginx
                EOF
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]

  tags = {
    Name = "nginx_server"
  }
  provisioner "local-exec" {
    command = <<-EOC
      aws ec2 wait instance-status-ok --instance-ids ${self.id}
      aws ec2 describe-instances --instance-ids ${self.id} --query "Reservations[*].Instances[*].PublicIpAddress" --output text
    EOC
  }
}

output "server_public_ip" {
  value = aws_instance.nginx_server.public_ip
  
}