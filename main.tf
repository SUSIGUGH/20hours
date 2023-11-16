terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Define the provider
provider "aws" {
  region = "us-east-1"
}


#vpc01.tf
# Define the VPC
resource "aws_vpc" "testvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "testvpc" 
  }
}

#subnet01.tf
# Define the subnets
resource "aws_subnet" "sub-us-east-1a" {
  vpc_id = aws_vpc.testvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "sub-us-east-1a"
  }
}

resource "aws_internet_gateway" "ig01" {
}


resource "aws_internet_gateway_attachment" "igattach" {
  internet_gateway_id = aws_internet_gateway.ig01.id
  vpc_id              = aws_vpc.testvpc.id
}



resource "aws_route_table" "routetb01" {
vpc_id              = aws_vpc.testvpc.id
}

resource "aws_route" "route01" {
  route_table_id            = aws_route_table.routetb01.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.ig01.id
}


resource "aws_route_table_association" "routetbassoc01" {
  subnet_id      = aws_subnet.sub-us-east-1a.id
  route_table_id = aws_route_table.routetb01.id
}

# Define the security group
resource "aws_security_group" "sg01" {
  name_prefix = "sg01_security_group"
  vpc_id = aws_vpc.testvpc.id

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



# Define the EC2 instances
resource "aws_instance" "httpd" {
  ami = "ami-0e8a34246278c21e4"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.sub-us-east-1a.id
  vpc_security_group_ids = [aws_security_group.sg01.id]
 tags = {
    Name = "httpd"
  }
  key_name = "susigugh-ec202.pem"
}




