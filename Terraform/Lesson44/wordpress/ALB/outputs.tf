output "nginx_wordpress_conf_wordpress_back_lb_url" {
  value = aws_lb.alb_back.dns_name
}