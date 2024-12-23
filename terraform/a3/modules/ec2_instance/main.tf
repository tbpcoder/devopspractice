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
  # ami           = var.aws_ami_id
  instance_type = var.instance_type
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