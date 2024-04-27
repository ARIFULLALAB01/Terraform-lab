#VPC Creation
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "aws-vpc-demo"
  }
}
#VPC Creation wuth subnet creation
resource "aws_subnet" "web" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "web-subnet"
  }

}
#Internategateway creation depends on vpc
resource "aws_internet_gateway" "int-gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "internetgw-demo"
  }

}
#Internategateway attachement to VPC-ID
resource "aws_internet_gateway_attachment" "int-gw-example" {
  internet_gateway_id = aws_internet_gateway.int-gw.id
  vpc_id              = aws_vpc.main.id
}
#Route table creation based upon internate gateway
resource "aws_route_table" "rt-table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.int-gw.id
  }
  tags = {
    Name = "rt-table-demo"
  }

}
#Route table Assosication and attched to subnet_ID
resource "aws_route_table_association" "rt-table-assis" {
  subnet_id      = aws_subnet.web.id
  route_table_id = aws_route_table.rt-table.id

}
#security group Creation
resource "aws_security_group" "aws-web-security" {
  name        = "aws-wed-demo"
  description = "Allow all port rules"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "open-all"
  }
}
#security group Creation with rules mentioned
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.aws-web-security.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
#security group Creation with rules mentioned
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.aws-web-security.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
#EC2-Instance creation
resource "aws_instance" "arifulla-demo" {
  instance_type = "t2.micro"
  ami           = "ami-0f58b397bc5c1f2e8" # change this
  subnet_id     = aws_subnet.web.id       # change this
  security_groups = [aws_security_group.aws-web-security.id]
  key_name                    = "test"
  associate_public_ip_address = true
  availability_zone = "ap-south-1a"
  tags = {
    Name = "Sample-test-VM"
  }
}