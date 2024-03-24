# resource "aws_route53_record" "acme_alb_dns" {
#   zone_id = var.route53_zone_id
#   name    = "acme.corp.widgets.com"
#   type    = "A"

#   alias {
#     name                   = aws_lb.acme_alb.dns_name
#     zone_id                = aws_lb.acme_alb.zone_id
#     evaluate_target_health = true
#   }
# }