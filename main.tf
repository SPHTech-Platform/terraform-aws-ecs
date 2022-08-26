locals {
  name = "awsdio-nextjs"

  mandatory_tags = {
    env         = "dev"
    app_tier    = "2"
    appteam     = "SPH Radio Agile Team"
    cost_centre = "4000"
    product     = "SPH Radio"
    biz_dept    = "DPE"
  }

  map_migrated = "d-server-00fyc0pr7gc8hv"

  standard_tags = merge(
    { for k, v in local.mandatory_tags : "sph:${replace(k, "_", "-")}" => v if v != null && v != "" },
    { map-migrated = local.map_migrated },
  )
}

module "ecs_cluster" {
  source = "./modules/ecs"

  name                              = format("%s-ecs", local.name)
  link_ecs_to_asg_capacity_provider = true
  # asg_arn                          = module.asg.autoscaling_group_arn

  # ASG
  asg_create = true

  asg_instance_name    = "ec2-asg-awedio-nextjs"
  asg_min_size         = "2"
  asg_max_size         = "4"
  asg_desired_capacity = "2"
  #   asg_subnets                           = var.asg_subnets         #get from ssm parameters
  asg_network_interface_security_groups = [aws_security_group.asg_sg.id]
  asg_image_id                          = "ami-01f890f0ede139c03" # bottlerocket AMI
  asg_instance_type                     = "m5.2xlarge"
  asg_volume_size                       = "30"
  #   asg_user_data_base64                  = base64encode(templatefile("${path.module}/../templates/userdata.tpl.sh", { ecs_cluster = module.ecs_cluster.ecs_cluster_name, aws_region = var.aws_region }))
  #   asg_iam_instance_profile_arn          = var.iam_instance_profile_arn
  #   tags                                  = local.standard_tags

  tags = local.standard_tags
  
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/aft/provisioned/vpc/vpc_id"
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

  tags = local.standard_tags
}
