
resource "aws_subnet" "backend" {

  for_each = local.private_subnets

  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block

}

resource "aws_route_table" "backend" {

  for_each = local.private_subnets

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[each.key].id
  }
}

resource "aws_route_table_association" "backend" {

  for_each = local.private_subnets

  subnet_id      = aws_subnet.backend[each.key].id
  route_table_id = aws_route_table.backend[each.key].id

}

resource "aws_eip" "nat" {

  for_each = local.private_subnets

}

resource "aws_nat_gateway" "nat" {

  for_each = local.private_subnets

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.frontend[each.key].id

  depends_on = [ 
    aws_internet_gateway.main,
    aws_eip.nat[each.key]
    ]

}