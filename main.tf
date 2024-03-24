# resource "aws_vpc" "acme_vpc" {
#     cidr_block = "10.0.0.0/16"
# }

# resource "aws_subnet" "acme_subnet1" {
#   vpc_id     = aws_vpc.acme_vpc.id
#   cidr_block = "10.0.1.0/24"
#   availability_zone = "us-east-1a"
# }

# resource "aws_subnet" "acme_subnet2" {
#   vpc_id     = aws_vpc.acme_vpc.id
#   cidr_block        = "10.0.2.0/24"
#   availability_zone = "us-east-1b"
# }


# resource "aws_launch_template" "template" {
#   name_prefix     = "acme_launch_template"
#   image_id        = var.acme_ami #bitnami-wordpress-6.4.3-7-r168-linux-debian-12-x86_64-hvm-ebs-nami
#   instance_type   = var.ec2_type
# }

# resource "aws_autoscaling_group" "autoscale" {
#   name                  = "acme_asg"  
#   desired_capacity      = 1
#   max_size              = 2
#   min_size              = 1
#   health_check_type     = "EC2"
#   termination_policies  = ["OldestInstance"]
#   vpc_zone_identifier   = [aws_subnet.acme_subnet1.id, aws_subnet.acme_subnet2.id]

#   launch_template {
#     id      = aws_launch_template.template.id
#     version = "$Latest"
#   }
# }