resource "aws_security_group" "ecs_sg" {
  #checkov:skip=CKV2_AWS_5:Security group is attached to another resource
  name        = "ecs-sg-${var.name}"
  description = "Allow inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description     = "Allow inbound traffic from the load balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_public_sg.id]
  }

  egress {
    description = "Allow outbound traffic from ECS"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-ec2-no-public-egress-sgr
  }
}

resource "aws_security_group" "lb_public_sg" {
  #checkov:skip=CKV_AWS_260:Load balancer security group requires ingress from all on port 80
  #checkov:skip=CKV2_AWS_5:Security group is attached to another resource
  name        = "lb-public-sg-${var.name}"
  description = "Allow inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow HTTP inbound traffic on the load balancer listener port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-ec2-no-public-ingress-sgr
  }
}

resource "aws_security_group_rule" "lb_sg_allow_all" {
  description       = "Allow all outbound traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.lb_public_sg.id
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:aws-ec2-no-public-egress-sgr
}
