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

# Create a security group for the EC2 instance
resource "aws_security_group" "acme_sg" {
  name        = "acme_app_ec2_sg"
  description = "Security group for EC2 instance acme_app"
  vpc_id      = aws_vpc.acme_vpc.id

  # Allow inbound HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}



# Launch an EC2 instance in the public subnet
resource "aws_instance" "acme_app" {
  ami             = var.acme_ami
  instance_type   = var.ec2_type
  key_name      = var.key_pem
  associate_public_ip_address = true
  subnet_id = aws_subnet.acme_subnet.id
  tags = {
    Name          = var.business_zone
    business_zone = var.business_zone
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "<html><body><h1>ACME Corp APP located at $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//')</h1></body></html>" > /var/www/html/index.html
              EOF

  vpc_security_group_ids = [aws_security_group.acme_sg.id]
}
