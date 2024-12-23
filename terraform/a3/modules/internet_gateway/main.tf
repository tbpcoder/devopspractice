# internet gateway
resource "aws_internet_gateway" "nginx_igw" {
  vpc_id = aws_vpc.nginx_server_vpc.id

  tags = {
    Name = "nginx_igw"
  }
}