module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.0"

  for_each = toset(["server1", "server2", "server3"])

  name = "instance-${each.key}"

  #name          = "single-instance"
  ami           = "ami-0c2af51e265bd5e0e"
  instance_type = "t2.micro"
  key_name      = "my-server"

  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address =  true

  tags = {
    Name        = "Project"
    Environment = "dev"
  }

}