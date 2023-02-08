output "nginx_wordpress_conf_wordpress_back_lb_url" {
  value = aws_lb.alb_back.dns_name
}


output "alb_front" {
  value = data.aws_lb_target_group.alb_front.arn
}

output "alb_back" {
  value = data.aws_lb_target_group.alb_back.arn
}