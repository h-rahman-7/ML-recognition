## My application load balancer
resource "aws_lb" "mlops_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids
  drop_invalid_header_fields = true
  # checkov:skip=CKV_AWS_150 "Reason: Deletion protection is disabled for Terraform destroy"
  enable_deletion_protection = false

  # access_logs {
  #   bucket  = "mlops-detection-app-bucket"
  #   prefix  = "alb-logs"
  #   enabled = true
  # }

  tags = {
    Environment = "production"
  }

}

## My ALB target group
resource "aws_lb_target_group" "mlops_alb_tg" {
  name        = var.target_group_name
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    protocol           = "HTTP"          # Use HTTP for health checks
    path               = "/"             # Path to check, e.g., root path
    interval           = 30              # Time between health checks (in seconds)
    timeout            = 5               # Timeout for each health check
    healthy_threshold  = 3               # Number of successes before considering the target healthy
    unhealthy_threshold = 2              # Number of failures before considering the target unhealthy
    matcher            = "200"           # Expect HTTP 200 response for a successful check
  }
}

## My ALB listener for HTTP redirecting to port 443
resource "aws_lb_listener" "mlops_http_listener" {
  load_balancer_arn = aws_lb.mlops_alb.arn
  port              = "80"
  protocol          = "HTTP"

  # default_action {
  #   type             = "forward"
  #   target_group_arn = aws_lb_target_group.mlops_alb_tg.arn
  # }  
  default_action {
    type = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }

}

## My ALB listener for HTTPS forwarding to port 3000
resource "aws_lb_listener" "mlops_https_listener" {
  load_balancer_arn = aws_lb.mlops_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn
 
 ssl_policy = "ELBSecurityPolicy-TLS-1-2-2017-01" # Enforce TLS 1.2

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mlops_alb_tg.arn
  }
}

