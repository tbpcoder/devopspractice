# subnet
resource "aws_subnet" "nginx_server_subnet" {
  vpc_id = aws_vpc.nginx_server_vpc.id
  cidr_block = var.subnet_cidr_block
  
  tags = {
    Name = "nginx_subnet"
  }
}