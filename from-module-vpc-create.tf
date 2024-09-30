provider "aws" {
  region = "ap-south-1"
}

data "aws_availability_zones" "name" {
  state = "available"
}

#create a new vpc using predefined aws vpc module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = "my-vpc"
  cidr = "20.0.0.0/16"
  
  azs = data.aws_availability_zones.name.names

  public_subnets  = ["20.0.0.0/24"]
  private_subnets = ["20.0.1.0/24"]
  
  tags = {
    Name = "Test-vpc-module"
  }
}

# create a new sg for this vpc 
resource "aws_security_group" "my_sg" {
  vpc_id = module.vpc.vpc_id

  name        = "new-sg"
  description = "Allow HTTP and SSH inbound, and all outbound"

  # Inbound rules
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  } 