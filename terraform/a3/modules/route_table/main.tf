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