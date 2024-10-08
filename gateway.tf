resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public_1a.id

  tags = {
    Name = "main-nat"
  }
}

resource "aws_eip" "main" {
  vpc = true
}
