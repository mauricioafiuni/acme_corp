#resource "aws_instance" "acme_app" {
#  ami             = var.acme_ami
#  instance_type   = var.ec2_type
#
# tags = {
#    Name = var.business_zone
#  }
#}

#resource "aws_instance" "import_demo" {
#  ami             = "ami-0c101f26f147fa7fd"
#  instance_type   = var.ec2_type
#}

resource "aws_instance" "acme_app" {
  ami             = var.acme_ami
  instance_type   = var.ec2_type
  key_name      = var.key_pem  
  
  tags = {
    Name = var.business_zone
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "<html><body><h1>This instance is located in $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//')</h1></body></html>" > /var/www/html/index.html
              EOF
}