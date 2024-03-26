resource "aws_instance" "acme_app" {
  ami             = var.acme_ami
  instance_type   = var.ec2_type

 tags = {
    Name = var.business_zone
  }
}

#resource "aws_instance" "import_demo" {
#  ami             = "ami-0c101f26f147fa7fd"
#  instance_type   = var.ec2_type
#}