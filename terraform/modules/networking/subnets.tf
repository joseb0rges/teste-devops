resource "aws_subnet" "public_subnets" {
  for_each                = { for subnet in var.public_subnets : subnet.name => subnet }
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = each.value.zone
  map_public_ip_on_launch = true
  cidr_block              = each.value.cidr_block

}




