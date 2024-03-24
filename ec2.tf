resource "aws_instance" "acme_app" {
  ami             = var.acme_ami #bitnami-wordpress-6.4.3-7-r168-linux-debian-12-x86_64-hvm-ebs-nami
  instance_type   = var.ec2_type
}