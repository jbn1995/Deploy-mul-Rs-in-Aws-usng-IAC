terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.68.0"
    }
  }
}
locals {
  project = "project-demo"
}
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count      = length(var.ec2-config)
  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}
resource "aws_instance" "main" {
  #using count for use the list type variables defining in terraform.tfvars file
  #count         = 2
  #ami           = var.ec2-config[count.index].ami
  #instance_type = var.ec2-config[count.index].instance_type
  #subnet_id = element(aws_subnet.main[*].id, count.index % length(aws_subnet.main))

  #using for_each to use the map type variables
  for_each = var.ec2-map
  #we will get each.key and each.value
  ami = each.value.ami
  instance_type = each.value.instance_type
  
  subnet_id = element(aws_subnet.main[*].id, index(keys(var.ec2-map), each.key) % length(aws_subnet.main))

  tags = {
    #Name = "${local.project}-instance-${count.index}"
    Name = "${local.project}-instance-${each.key}"
  }
}
