
resource "aws_subnet" "backend" {

  for_each = local.public_subnets

  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block

  depends_on = [random_shuffle.az]

}

# must allow IGW access to the internet
resource "aws_route_table" "backend" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "backend" {

  for_each = aws_subnet.backend

  subnet_id      = each.value.id
  route_table_id = aws_route_table.backend.id

}
