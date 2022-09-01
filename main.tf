locals {
  name = "awedio"
  aws_env = "dev"

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
      container_definitions = jsonencode([
        module.container_awedio_nextjs.json_map_object
      ])
      task_cpu      = 256
      task_memory   = 512
      desired_count = 1
      # ecs_load_balancers = [
      #   {
      #     target_group_arn = element(module.alb.target_group_arns, 1),
      #     container_name   = "drop-resolver-dcx",
      #     container_port   = "8095"
      #   },
      #   {
      #     target_group_arn = element(module.alb.target_group_arns, 2),
      #     container_name   = "drop-resolver-print",
      #     container_port   = "8096"
      #   },
      # ]
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

data "aws_ssm_parameter" "vpc_id" {
  name = "/aft/provisioned/vpc/vpc_id"
}

data "aws_ssm_parameter" "private_subnets" {
  name = "/aft/provisioned/vpc/private_subnets"
}

data "aws_ssm_parameter" "bottlerocket_ami" {
  name = "/aws/service/bottlerocket/aws-ecs-1/x86_64/latest/image_id"
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

  # tags = local.standard_tags
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
  asg_network_interface_security_groups = [aws_security_group.asg_sg.id]
  # asg_image_id                          = "ami-01f890f0ede139c03" # bottlerocket AMI
  asg_image_id                          = data.aws_ssm_parameter.bottlerocket_ami.value
  asg_instance_type                     = "m5.2xlarge"
  asg_volume_size                       = "30"
  asg_iam_instance_profile_arn          = module.ecs_instance_role.iam_instance_profile_arn
  asg_user_data_base64                  = base64encode(templatefile("${path.module}/user_data.toml", { name = local.name }))

  # Service
  service_map = local.service_map
  # service_execution_role = module.ecs_task_execution_role.iam_role_arn




  # tags = local.standard_tags

}

resource "aws_security_group" "asg_sg" {
  name        = format("%s-sg", local.name)
  description = "Allow inbound traffic"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  ingress { # ingress from load balancer
    description = "Ingress from HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { # ingress from load balancer
    description = "Ingress from HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # tags = local.standard_tags
}
