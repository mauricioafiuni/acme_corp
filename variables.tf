variable "acme_ami" {
  type = string
  default = "ami-0c101f26f147fa7fd"
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

variable "key_pem" {
  type = string
  default = "acme_key_us"
}