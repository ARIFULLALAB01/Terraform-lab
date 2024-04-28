# VPC-Creattion
resource "aws_vpc" "Niter-network-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Niter-aws-vpc"
  }
}

#subnet creation for "web-subnet"
resource "aws_subnet" "Niter-network-sub" {
  cidr_block = var.web_cidr
  vpc_id     = aws_vpc.Niter-network-vpc.id
  tags = {
    Name = "web-subnet"
  }
  depends_on = [aws_vpc.Niter-network-vpc]
}

#subnet creation for "business-subnet"
resource "aws_subnet" "Niter-network-sub1" {
  cidr_block = var.business_cidr
  vpc_id     = aws_vpc.Niter-network-vpc.id
  tags = {
    Name = "business-subnet"
  }
  depends_on = [aws_vpc.Niter-network-vpc]
}

#subnet creation for "data-subnet"
resource "aws_subnet" "Niter-network-sub2" {
  cidr_block = var.data_cidr
  vpc_id     = aws_vpc.Niter-network-vpc.id
  tags = {
    Name = "data-subnet"
  }
  depends_on = [aws_vpc.Niter-network-vpc]
}