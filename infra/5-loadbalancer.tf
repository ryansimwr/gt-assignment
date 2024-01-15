resource "aws_lb" "alb_front" {
  depends_on                 = [aws_internet_gateway.igw]
  name                       = "dev-alb-public"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.lb.id]
  subnets                    = [for subnet in aws_subnet.public : subnet.id]
  enable_deletion_protection = false

  tags = {
    Environment = "Development"
  }
}

resource "aws_lb_target_group" "alb_front_tg" {
  name     = "alb-front-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id
}

resource "aws_lb_listener" "alb_front_listener" {
  load_balancer_arn = aws_lb.alb_front.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_front_tg.arn
  }
}
