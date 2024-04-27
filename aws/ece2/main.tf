data "aws_vpc" "default" {
  default = true


}
output "vpc" {
  value = data.aws_vpc.default.id

}

#security group Creation
resource "aws_security_group" "aws-web-security" {
  name        = "aws-wed-demo"
  description = "Allow all port rules"
  vpc_id      = data.aws_vpc.default.id
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
  instance_type               = "t2.micro"
  ami                         = "ami-0f58b397bc5c1f2e8" # change this
  security_groups             = [aws_security_group.aws-web-security.id]
  subnet_id = 
  key_name                    = "test"
  associate_public_ip_address = true
  availability_zone           = "ap-south-1a"
  tags = {
    Name = "Sample-test-VM"
  }
} 