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


