variable "exam_network_cidr" { default = "10.0.0.0/16" }
variable "exam_subnet_cidr" { default = "10.0.1.0/24" }

resource "aws_vpc" "main" {
  cidr_block           = var.exam_network_cidr
  enable_dns_hostnames = true
  tags                 = { Name = "rhce-vpc" }
}

resource "aws_internet_gateway" "gw" { vpc_id = aws_vpc.main.id }

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.exam_subnet_cidr
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

output "vpc_id" { value = aws_vpc.main.id }
output "subnet_id" { value = aws_subnet.public.id }
