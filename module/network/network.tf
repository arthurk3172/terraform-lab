
#*******************Network*******************************

data "aws_availability_zones" "available" {}


resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "vpc-${var.owner}"
  }
}

// Internet gateway 

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "igw-${var.owner}"
  }
}

#-------------Public Subnets and Routing---------------------------------------

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "net-${var.owner}-public-web-${count.index + 1}"
    AZ   = data.aws_availability_zones.available.names[count.index]
  }
}

resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id

  }
  tags = {
    "Name" = "rtb-${var.owner}-public"
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.public_subnets.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}


#--------------Private Subnets and Routing-------------------------

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "net-${var.owner}-private-rpd-${count.index + 1}"
    AZ   = data.aws_availability_zones.available.names[count.index]
  }
}

resource "aws_route_table" "private_subnets" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "rtb-${var.owner}-private"
  }
}

resource "aws_route_table_association" "private_routes" {
  count          = length(aws_subnet.private_subnets[*].id)
  route_table_id = aws_route_table.private_subnets.id
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
}

#==============================================================

