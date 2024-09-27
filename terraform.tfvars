#defining value in list format
ec2-config = [
  {
    ami           = "ami-0522ab6e1ddcc7055" #ubuntu
    instance_type = "t2.micro"
  },
  {
    ami           = "ami-08718895af4dfa033" # amazon
    instance_type = "t2.micro"
}]

#defininig value in key=value format/map format
ec2-map = {
  "ubuntu" = {
    ami           = "ami-0522ab6e1ddcc7055" 
    instance_type = "t2.micro"
  },
    "amazon-linux" = {
    ami           = "ami-08718895af4dfa033" 
    instance_type = "t2.micro"
  }
}