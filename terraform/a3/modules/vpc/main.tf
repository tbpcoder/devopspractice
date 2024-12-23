# vpc
resource "aws_vpc" "nginx_server_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name="nginx_vpc"
  }
}