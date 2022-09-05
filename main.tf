locals {
  name    = "awedio"
  aws_env = "dev"
  domain_name = "sandbox-653505252669.platform.sphdigital.com.sg"

  # mandatory_tags = {
  #   env         = "dev"
  #   app_tier    = "2"
  #   appteam     = "SPH Radio Agile Team"
  #   cost_centre = "4000"
  #   product     = "SPH Radio"
  #   biz_dept    = "DPE"
  # }

  # map_migrated = "d-server-00fyc0pr7gc8hv"

  # standard_tags = merge(
  #   { for k, v in local.mandatory_tags : "sph:${replace(k, "_", "-")}" => v if v != null && v != "" },
  #   { map-migrated = local.map_migrated },
  # )

  service_map = {
    nextjs = {
      create          = true
      service_scaling = true
      service_container_definitions = jsonencode([
        module.container_awedio_nextjs.json_map_object
      ])
      service_task_cpu      = 256
      service_task_memory   = 512
      service_desired_count = 1
      ecs_load_balancers = [
        {
          target_group_arn = element(module.alb.target_group_arns, 0),
          container_name   = "awedio-nextjs",
          container_port   = "3000"
        }
      ]
    }
    # wordpress = {
    #   create          = true
    #   service_scaling = true
    #   container_definitions = jsonencode([
    #     module.container_awedio_nextjs.json_map_object
    #   ])
    #   task_cpu      = 256
    #   task_memory   = 512
    #   desired_count = 1
    #   # ecs_load_balancers = [
    #   #   {
    #   #     target_group_arn = element(module.alb.target_group_arns, 0),
    #   #     container_name   = "cook",
    #   #     container_port   = "8101"
    #   #   },
    #   # ]
    # }
  }
}

##### Manually created in AWS console #####
# module "zones" {
#   source  = "terraform-aws-modules/route53/aws//modules/zones"
#   version = "~> 1.0"

#   zones = {
#     "${local.domain_name}" = {
#       tags = {
#         env = "development"
#       }
#     }
#   }
# }

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name = local.domain_name
  # zone_id     = keys(module.zones.route53_zone_zone_id)[0]
  zone_id     = "Z01336191IWO7D9W5I8XT"

  subject_alternative_names = [
    "*.${local.domain_name}",
  ]

  wait_for_validation = false

  tags = {
    Name = local.domain_name
  }
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = format("alb-%s", local.name)

  internal           = false
  load_balancer_type = "application"
  vpc_id             = "${data.aws_ssm_parameter.vpc_id.value}"
  security_groups    = [ aws_security_group.lb_sg.id ]
  # subnets            = [ data.aws_ssm_parameter.public_subnets.value ]
  subnets            = split(",", data.aws_ssm_parameter.public_subnets.value)

  listener_ssl_policy_default = "ELBSecurityPolicy-FS-1-2-Res-2020-10"


  https_listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = module.acm.acm_certificate_arn
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  target_groups = [
    {
      name             = format("tg-%s-nextjs-%s", local.name, local.aws_env)
      backend_protocol = "HTTP"
      backend_port     = 3000
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 15
        path                = "/api/probe/"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }
    }
  ]

  tags = { "Name" : local.name }

  target_group_tags = { Name = local.name }
}

module "ecs_instance_role" {
  source = "./modules/iam"

  role_name             = format("ecs-instance-role-%s", local.name)
  trusted_role_services = ["ec2.amazonaws.com"]
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  ]
  create_user             = false
  create_instance_profile = true
}

module "ecs_task_execution_role" {
  source = "./modules/iam"

  role_name             = format("ecs-task-execution-role-%s-%s", local.name, local.aws_env)
  trusted_role_services = ["ecs-tasks.amazonaws.com"]
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
  create_user             = false
  create_instance_profile = false
  policy                  = templatefile("${path.module}/task_execution_custom_policy.tpl.json", { env = local.aws_env, app = local.name, region = data.aws_region.current.name, account = data.aws_caller_identity.current.account_id })
  policy_name             = format("ecs-task-execution-policy-%s-%s", local.name, local.aws_env)
}

module "ecs_task_role" {
  source = "./modules/iam/"

  role_name               = format("ecs-task-role-%s-%s", local.name, local.aws_env)
  trusted_role_services   = ["ecs-tasks.amazonaws.com"]
  create_user             = false
  create_instance_profile = false
  policy                  = templatefile("${path.module}/task_custom_policy.tpl.json", { region = data.aws_region.current.name, account = data.aws_caller_identity.current.account_id })
  policy_name             = format("ecs-task-policy-%s-%s", local.name, local.aws_env)
}

module "ecs_cluster" {
  source = "./modules/ecs"

  name                              = local.name
  link_ecs_to_asg_capacity_provider = true

  # ASG
  asg_create                            = true
  asg_name                              = local.name
  asg_instance_name                     = local.name
  asg_min_size                          = "2"
  asg_max_size                          = "4"
  asg_desired_capacity                  = "2"
  asg_protect_from_scale_in             = true
  asg_subnets                           = [data.aws_ssm_parameter.private_subnets.value]
  asg_network_interface_security_groups = [aws_security_group.ecs_sg.id]
  # asg_image_id                          = "ami-01f890f0ede139c03" # bottlerocket AMI
  asg_image_id                 = data.aws_ssm_parameter.bottlerocket_ami.value
  asg_instance_type            = "m5.2xlarge"
  asg_volume_size              = "30"
  asg_iam_instance_profile_arn = module.ecs_instance_role.iam_instance_profile_arn
  asg_user_data_base64         = base64encode(templatefile("${path.module}/user_data.toml", { name = local.name }))

  # Service
  service_map                 = local.service_map
  service_task_execution_role_arn = module.ecs_task_execution_role.iam_role_arn
  service_task_role_arn           = module.ecs_task_role.iam_role_arn
  # service_subnets             = [data.aws_ssm_parameter.private_subnets.value]
  # service_subnets             = ["subnet-083e1b4fecfb9680b","subnet-0d8846d6bffdb06ed","subnet-0d19ac19f27184b07"]
  service_subnets             = split(",", data.aws_ssm_parameter.private_subnets.value)
  service_security_groups     = [aws_security_group.ecs_sg.id]
}

resource "aws_security_group" "lb_sg" {
  name        = format("%s-lb-sg", local.name)
  description = "Allow inbound traffic"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress {
    description      = "Allow HTTP inbound traffic on the load balancer listener port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow HTTPS inbound traffic on the load balancer listener port"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "lb_sg_egress" {
  type = "egress"
  from_port = 3000
  to_port = 3000
  protocol = "tcp"
  security_group_id = "${aws_security_group.lb_sg.id}"
  source_security_group_id = "${aws_security_group.ecs_sg.id}"
}

resource "aws_security_group_rule" "lb_sg_allow_all" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = "${aws_security_group.lb_sg.id}"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group" "ecs_sg" {
  name        = format("%s-ecs-sg", local.name)
  description = "Allow inbound traffic"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress {
    description = "Allow inbound traffic from the load balancer"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    security_groups = [ aws_security_group.lb_sg.id ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

