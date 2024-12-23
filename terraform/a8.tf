# Variables for ingress rules
variable "ingress_rules" {
  description = "List of ingress rules for the security group"
  default = [
    { from_port = 80,  to_port = 80,  protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 22,  to_port = 22,  protocol = "tcp", cidr_blocks = ["192.168.1.0/24"] }
  ]
}

# Variable for instance type and AMI
variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0c02fb55956c7d316" # Example Amazon Linux 2 AMI
}

# Security Group with dynamic ingress rules
resource "aws_security_group" "example_sg" {
  name        = "example_sg"
  description = "Security Group for example EC2 instance"
  vpc_id      = "vpc-xxxxxxxx" # Replace with your VPC ID

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  tags = {
    Name = "example_sg"
  }
}

# EC2 instance using the security group
resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.example_sg.name]

  tags = {
    Name = "example_instance"
  }
}

# Output for EC2 instance details
output "ec2_instance_public_ip" {
  value = aws_instance.example.public_ip
}

output "ec2_instance_id" {
  value = aws_instance.example.id
}
