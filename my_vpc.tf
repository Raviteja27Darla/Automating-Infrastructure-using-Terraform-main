# Providing AWS Provider
provider "aws" {
    region                  = "us-east-1"
}

# Creating AWS VPC
resource "aws_vpc" "my_vpc" {
    cidr_block              = "10.10.0.0/16"
    tags                    = {Name = "my_vpc"}
}

# Creating AWS Subnet
resource "aws_subnet" "my_subnet" {
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = "10.10.0.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true
    tags                    = {Name = "my_subnet"}
}

# Creating AWS Internet Gateway
resource "aws_internet_gateway" "my_internet_getaway" {
    vpc_id                  = aws_vpc.my_vpc.id
    tags                    = {Name = "my_internet_getaway"}
}

# Creating AWS Route Table
resource "aws_route_table" "my_route_table" {
    vpc_id                  = aws_vpc.my_vpc.id
    route  { 
        cidr_block          = "0.0.0.0/0"
        gateway_id          = aws_internet_gateway.my_internet_getaway.id
    }
    tags                    = {Name = "my_rout_table"}
}

# Creating AWS Subnet Association Connecting Subnet with Route Table
resource "aws_route_table_association" "my_route_table_association"{
    subnet_id               = aws_subnet.my_subnet.id
    route_table_id          = aws_route_table.my_route_table.id
} 

# Creating AWS Security Group
resource "aws_security_group" "my_security_group" {
    vpc_id                  = aws_vpc.my_vpc.id
    tags                    = {Name = "my_security_group"}
    ingress {
        description         = "SSH"
        from_port           = 22
        to_port             = 22
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    ingress {
        description         = "http"
        from_port           = 8080
        to_port             = 8080
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    ingress {
        description         = "http"
        from_port           = 80
        to_port             = 80
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    egress {
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_blocks         = ["0.0.0.0/0"]
    }
}
