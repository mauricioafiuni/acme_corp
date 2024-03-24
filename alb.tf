# resource "aws_lb" "acme_alb" {
#   name               = "acme-alb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.acme_alb_sg.id]
#   subnets            = [aws_subnet.acme_subnet1.id, aws_subnet.acme_subnet2.id]

#   tags = {
#     Name = "acme-alb"
#   }
# }

# resource "aws_lb_listener" "alb_listener" {
#   load_balancer_arn = aws_lb.acme_alb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.acme_target_group.arn
#   }
# }

# resource "aws_lb_target_group" "acme_target_group" {
#   name     = "acme-target-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.acme_vpc.id

#   health_check {
#     path                = "/"
#     port                = "traffic-port"
#     protocol            = "HTTP"
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 3
#     interval            = 30
#   }
# }

# resource "aws_lb_listener_rule" "alb_listener_rule" {
#   listener_arn = aws_lb_listener.alb_listener.arn
#   priority     = 100

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.acme_target_group.arn
#   }

#   condition {
#     host_header {
#       values = ["example.com"]
#     }
#   }
# }

# resource "aws_security_group" "acme_alb_sg" {
#   name        = "acme-alb-sg"
#   description = "Security group for ACME Application Load Balancer"

#   vpc_id = aws_vpc.acme_vpc.id

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]  
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "acme-alb-sg"
#   }
# }