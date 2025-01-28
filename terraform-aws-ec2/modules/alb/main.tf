//* Import an existing acm certificate for the loadbalancer https listener *//

# data "aws_acm_certificate" "existing_cert" {
#   domain      = var.domain  
#   statuses    = ["ISSUED"]         
#   most_recent = true              
# }

# Security group for the second LB
resource "aws_security_group" "lb_secondary" {
  name   = "${var.name}-secondary-sg"
  vpc_id = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["172.31.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}


# Second LB
resource "aws_lb" "secondary_lb" {
  name                   = "${var.name}-secondary"
  internal               = true
  load_balancer_type     = "application"
  subnets                = var.public_subnets
  security_groups        = [aws_security_group.lb_secondary.id]
  enable_deletion_protection = false

  tags = var.tags
}


# Target group for the second LB
resource "aws_lb_target_group" "secondary_tg" {
  name        = "${var.name}-secondary-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 100
    timeout             = 90
    healthy_threshold   = 2
    unhealthy_threshold = 10
    matcher             = "200-399"
  }

  tags = var.tags
}

resource "aws_lb_target_group_attachment" "secondary_attachment" {
  target_group_arn = aws_lb_target_group.secondary_tg.arn
  target_id        = var.second_instance_id
  port             = 80
}


# Listener for the second LB
resource "aws_lb_listener" "secondary_http_listener" {
  load_balancer_arn = aws_lb.secondary_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.secondary_tg.arn
    type             = "forward"
  }

  tags = var.tags
}
