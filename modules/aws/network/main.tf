
# Random ID to assign to module
resource "random_id" "main" {
  byte_length = 8
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  assign_generated_ipv6_cidr_block = true
  
  tags = {
    Name = "${var.name}-${random_id.main.hex}"
  }
}

# Create subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_block
  
  map_public_ip_on_launch = true

  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 1)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.name}-${random_id.main.hex}"
  }

  depends_on = [aws_vpc.main]
}

# Create internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-${random_id.main.hex}"
  }

  depends_on = [aws_vpc.main]
}

# Create route table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  route {
      ipv6_cidr_block = "::/0"
      gateway_id      = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.name}-${random_id.main.hex}"
  }

  depends_on = [aws_vpc.main]
}

# Associate route table with subnet
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id

  depends_on = [
    aws_subnet.main,
    aws_route_table.main
  ]
}
