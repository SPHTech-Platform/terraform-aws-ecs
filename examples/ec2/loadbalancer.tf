module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "alb-${var.name}"

  internal           = false
  load_balancer_type = "application"
  vpc_id             = data.aws_ssm_parameter.vpc_id.value
  security_groups    = [aws_security_group.lb_public_sg.id]
  subnets            = split(",", data.aws_ssm_parameter.public_subnets.value)

  listener_ssl_policy_default = "ELBSecurityPolicy-FS-1-2-Res-2020-10"

  http_tcp_listeners = [
    {
      port     = 80
      protocol = "HTTP"
    }
  ]

  target_groups = [
    {
      name             = "tg-${var.name}-httpd"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 15
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }
    }
  ]

  http_tcp_listener_rules = [
    {
      http_tcp_listener_index = 0
      priority                = 1

      actions = [{
        type               = "forward"
        target_group_index = 0
      }]

      conditions = [{
        path_patterns = ["/"]
      }]
    }
  ]
}
