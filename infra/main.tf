############################
# VPC
############################

resource "aws_vpc" "node-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "node-vpc"
  }
}

############################
# Internet Gateway
############################

resource "aws_internet_gateway" "node-gw" {
  vpc_id = aws_vpc.node-vpc.id

  tags = {
    Name = "node-gw"
  }
}

############################
# Public Subnets
############################

resource "aws_subnet" "public-subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.node-vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

############################
# Private Subnets
############################

resource "aws_subnet" "private-subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.node-vpc.id
  cidr_block              = "10.0.${count.index + 10}.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zones[count.index]

  tags = {
    Name = "private-subnet-${count.index}"
  }
}

############################
# Elastic IP
############################

resource "aws_eip" "node-eip" {
  domain = "vpc"
}

############################
# NAT Gateway
############################

resource "aws_nat_gateway" "node-nat" {
  allocation_id = aws_eip.node-eip.id
  subnet_id     = aws_subnet.public-subnet[0].id

  depends_on = [aws_internet_gateway.node-gw]

  tags = {
    Name = "node-nat"
  }
}

############################
# Public Route Table
############################

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.node-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.node-gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

############################
# Private Route Table
############################

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.node-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.node-nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

############################
# Route Table Associations
############################

resource "aws_route_table_association" "public-rta" {
  count          = length(aws_subnet.public-subnet)
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private-rta" {
  count          = length(aws_subnet.private-subnet)
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.private-rt.id
}

############################
# ECR Repository
############################

resource "aws_ecr_repository" "app" {
  name         = "node-repo"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

############################
# Kubernetes Provider
############################

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}