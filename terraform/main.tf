resource "aws_vpc" "tic-tac-vpc" {
  cidr_block = var.aws_vpc
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "tic-tac-vpc"
  }
}

resource "aws_subnet" "tic-tac-subnet" {
  vpc_id                  = aws_vpc.tic-tac-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "tic-tac-subnet"
  }
}

resource "aws_internet_gateway" "tic-tac-igw" {
  vpc_id = aws_vpc.tic-tac-vpc.id
  tags = {
    Name = "tic-tac-igw"
  }
}

resource "aws_route_table" "tic-tac-route-table" {
  vpc_id = aws_vpc.tic-tac-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tic-tac-igw.id
  }
  tags = {
    Name = "tic-tac-route-table"
  }
}

resource "aws_route_table_association" "tic-tac-route-table-association" {
  subnet_id      = aws_subnet.tic-tac-subnet.id
  route_table_id = aws_route_table.tic-tac-route-table.id
}

resource "aws_security_group" "tic-tac-sg" {
  name        = "tic-tac-sg"
  description = "Allow inbound traffic on port 8080, 22, and 80"
  vpc_id      = aws_vpc.tic-tac-vpc.id

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "tic-tac" {
  ami                      = var.ami
  instance_type            = var.instance_type
  key_name                 = var.aws_key_name
  subnet_id                = aws_subnet.tic-tac-subnet.id
  vpc_security_group_ids   = [aws_security_group.tic-tac-sg.id]
  associate_public_ip_address = true
  

  tags = {
    Name = "GitOps server"
  }

  