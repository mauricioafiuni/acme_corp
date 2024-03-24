resource "aws_instance" "acme_app" {
  ami             = var.acme_ami
  instance_type   = var.ec2_type

 tags = {
    Name = var.business_zone
  }
}