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

#resource "aws_instance" "acme_app" {
#  ami             = var.acme_ami
#  instance_type   = var.ec2_type
#  key_name      = var.key_pem  
#  
#  tags = {
#    Name = var.business_zone
#  }
#
#  user_data = <<-EOF
#              #!/bin/bash
#              echo "<html><body><h1>This instance is located in $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//')</h1></body></html>" > /var/www/html/index.html
#              EOF
#}


# Create a VPC for ACME app
resource "aws_vpc" "acme_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name          = "acme_vpc"
    business_zone = var.business_zone
  }
}

# Create a public subnet within the ACME VPC
resource "aws_subnet" "acme_subnet" {
  vpc_id                  = aws_vpc.acme_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name          = "acme_subnet"
    business_zone = var.business_zone
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "acme_igw" {
  vpc_id = aws_vpc.acme_vpc.id

  tags = {
    Name          = "acme_igw"
    business_zone = var.business_zone
  }
}

# Attach the internet gateway to the VPC
resource "aws_vpc_attachment" "acme_igw_attachment" {
  vpc_id             = aws_vpc.acme_vpc.id
  internet_gateway_id = aws_internet_gateway.acme_igw.id
}

# Create a route table for public internet access
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.acme_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.acme_igw.id
  }

  tags = {
    Name          = "public_route_table"
    business_zone = var.business_zone
  }
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.acme_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Launch an EC2 instance in the public subnet
resource "aws_instance" "acme_app" {
   ami             = var.acme_ami
  instance_type   = var.ec2_type
  key_name      = var.key_pem
  subnet_id     = aws_subnet.acme_subnet.id

  tags = {
    Name          = "acme_ec2_instance"
    business_zone = var.business_zone
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "<html><body><h1>ACME Corp APP located at $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//')</h1></body></html>" > /var/www/html/index.html
              EOF

  # Additional configuration like security groups, IAM role, etc. can be added here
}
