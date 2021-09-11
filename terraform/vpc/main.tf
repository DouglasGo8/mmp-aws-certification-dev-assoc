resource "aws_vpc" "main-vpc" {
  cidr_block           = var.CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.AWS_PROJECT_NAME}-vpc-${var.AWS_ENVIRONMENT}"
    Environment = var.AWS_ENVIRONMENT
  }
}

# Internet Gateway must be associated with route table and public subnets (RDS with Publicily Access needs this)
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name        = "${var.AWS_PROJECT_NAME}-igw-${var.AWS_ENVIRONMENT}"
    Environment = var.AWS_ENVIRONMENT
  }
}

resource "aws_eip" "nat-eip" {
  count = length(var.AWS_PRIVATE_SUBNETS)
  vpc   = true

  tags = {
    Name        = "${var.AWS_PROJECT_NAME}-eip-${var.AWS_ENVIRONMENT}-${format("%03d", count.index + 1)}"
    Environment = var.AWS_ENVIRONMENT
  }
}

# Nat gateways must to refer internet gateway and public subnets
resource "aws_nat_gateway" "main-ngw" {
  count         = length(var.AWS_PRIVATE_SUBNETS)
  allocation_id = element(aws_eip.nat-eip.*.id, count.index)
  subnet_id     = element(aws_subnet.subnet-public.*.id, count.index)
  depends_on    = [aws_internet_gateway.main-igw]

  tags = {
    Name        = "${var.AWS_PROJECT_NAME}-nat-${var.AWS_ENVIRONMENT}-${format("%03d", count.index + 1)}"
    Environment = var.AWS_ENVIRONMENT
  }

}

resource "aws_subnet" "subnet-private" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = element(var.AWS_PRIVATE_SUBNETS, count.index)
  availability_zone       = element(var.AWS_AVAILABILITY_ZONES, count.index)
  count                   = length(var.AWS_PRIVATE_SUBNETS)
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.AWS_PROJECT_NAME}-private-subnet-${var.AWS_ENVIRONMENT}-${format("%03d", count.index + 1)}"
    Environment = var.AWS_ENVIRONMENT
  }
}

resource "aws_subnet" "subnet-public" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = element(var.AWS_PUBLIC_SUBNETS, count.index)
  availability_zone       = element(var.AWS_AVAILABILITY_ZONES, count.index)
  count                   = length(var.AWS_PUBLIC_SUBNETS)
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.AWS_PROJECT_NAME}-public-subnet-${var.AWS_ENVIRONMENT}-${format("%03d", count.index + 1)}"
    Environment = var.AWS_ENVIRONMENT
  }
}

resource "aws_route_table" "route-table-public" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name        = "${var.AWS_PROJECT_NAME}-routing-table-public"
    Environment = var.AWS_ENVIRONMENT
  }
}

resource "aws_route" "route-public" {
  route_table_id         = aws_route_table.route-table-public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main-igw.id
}

resource "aws_route_table" "route-table-private" {
  count  = length(var.AWS_PRIVATE_SUBNETS)
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name        = "${var.AWS_PROJECT_NAME}-routing-table-private-${format("%03d", count.index + 1)}"
    Environment = var.AWS_ENVIRONMENT
  }
}

resource "aws_route" "route-private" {
  count                  = length(compact(var.AWS_PRIVATE_SUBNETS))
  route_table_id         = element(aws_route_table.route-table-private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.main-ngw.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count          = length(var.AWS_PRIVATE_SUBNETS)
  subnet_id      = element(aws_subnet.subnet-private.*.id, count.index)
  route_table_id = element(aws_route_table.route-table-private.*.id, count.index)
}

resource "aws_route_table_association" "public" {
  count          = length(var.AWS_PUBLIC_SUBNETS)
  subnet_id      = element(aws_subnet.subnet-public.*.id, count.index)
  route_table_id = aws_route_table.route-table-public.id
}

# SSH Security Group
resource "aws_security_group" "sg-ssh" {
  name   = "${var.AWS_PROJECT_NAME}-sg-alb-${var.AWS_ENVIRONMENT}"
  vpc_id = aws_vpc.main-vpc.id

  ingress {
    protocol         = "tcp"
    from_port        = 22
    to_port          = 22
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.AWS_PROJECT_NAME}-sg-alb-${var.AWS_ENVIRONMENT}"
    Environment = var.AWS_ENVIRONMENT
  }
}
