output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb.mlops_alb.arn 
}

output "alb_url" {
  description = "The URL of the Application Load Balancer"
  value       = aws_lb.mlops_alb.dns_name
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.mlops_alb_tg.arn
}

output "http_listener" {
  description = "The ID of the HTTP Listener"
  value       = aws_lb_listener.mlops_http_listener.id
}

output "https_listener" {
  description = "The ID of the HTTPS Listener"
  value       = aws_lb_listener.mlops_https_listener.id
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.mlops_alb.dns_name
}