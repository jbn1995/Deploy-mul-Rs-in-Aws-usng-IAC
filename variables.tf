variable "ec2-config" {
  type = list(object({
    ami           = string
    instance_type = string
  }))
}
variable "ec2-map" {
    #key=value (object{ami, inst_type})
  type = map(object({
    ami = string
    instance_type = string
  }))
}