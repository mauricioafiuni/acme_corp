variable "acme_ami" {
  type = string
  default = "ami-0c54bf137edcd738a"
}

variable "ec2_type" {
  type = string
  default = "t2.micro"
}

variable "business_zone" {
  type = string
  default = "acme_us"
}

variable "region" {
  type = string
  default = "us-east-1"
}