#create VPC
resource "aws_vpc" "my_vpc" {
 cidr_block = "10.0.0.0/16"
 tags = {
   Name = "my_vpc"
 }
#private subnet
resource "aws_subnet" "private-subnet" {
 cidr_block = "10.0.0.1/24"
 vpc_id = aws_vpc.my_vpc.id
 tags = {
   Name = "private-subnet"
 }
#public subnet
resource "aws_subnet" "public-subnet" {
 cidr_block = "10.0.0.2/24"
 vpc_id = aws_vpc.my_vpc.id
 tags = {
  Name = "public-subnet"
 }
#internet gateway
resource "aws_internet_gateway" "my-igw" {
 vpc_id = aws_vpc.my_vpc.id
 tags = {
   Name = "my-igw"
 }
}
#routing table
resource "aws_route_table" "my-rt" {
 vpc_id = aws_vpc.my_vpc.id
 route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my-igw.id
 }
}
#route table association
resource "aws_route_table_association" "public-rts" {
 route_table_id = aws_route_table.my-rt.id
 subnet_id = aws_subnet.public-subnet.id
}
#ec2 instance
resource "aws_instance" "nginx-server" {
 ami = "ami-02c7683e4ca3ebf58"
 instance_type = "t2.micro"
 subnet_id = aws_subnet.public-subnet.id
 vpc_security_group_ids = [aws_security_group.nginx-sg1.id]
 associate_public_ip_address = true
 user_data = << - EOF
			 #!bin/bash
			 sudo apt install nginx
			 sudo systemctl start nginx
			 EOF
 tags = {
  Name = "nginx-server"
 }
}
#security group
resource "aws_security_group" "nginx-sg1" {
 vpc_id = aws_vpc.my_vpc.id
#inbound rule
 ingress {
 from_port = 80
 to_port = 80
 protocol = "tcp"
 cidr_block = ["0.0.0.0/0"]
 }
#outbound rule
 egress {
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_block = ["0.0.0.0/0']
 }
 tags = {
  Name = "nginx-server1"
 }
}
