module "ecs_cluster" {
  source = "./modules/ecs"

  name                              = "awedio-nextjs"
  link_ecs_to_asg_capacity_provider = true
  # asg_arn                          = module.asg.autoscaling_group_arn

  # ASG
  asg_create = true

  asg_instance_name    = "ec2-asg-awedio-nextjs"
  asg_min_size         = "2"
  asg_max_size         = "4"
  asg_desired_capacity = "2"
  #   asg_subnets                           = var.asg_subnets         #get from ssm parameters
  asg_network_interface_security_groups = ["asd"]                 #get from ssm parameters
  asg_image_id                          = "ami-01f890f0ede139c03" # bottlerocket AMI
  asg_instance_type                     = "m5.2xlarge"
  asg_volume_size                       = "30"
  #   asg_user_data_base64                  = base64encode(templatefile("${path.module}/../templates/userdata.tpl.sh", { ecs_cluster = module.ecs_cluster.ecs_cluster_name, aws_region = var.aws_region }))
  #   asg_iam_instance_profile_arn          = var.iam_instance_profile_arn
  #   tags                                  = local.standard_tags

  # tags
  standard_tags = {
    env         = "dev"
    app_tier    = "2"
    appteam     = "SPH Radio Agile Team"
    cost_centre = "4000"
    product     = "SPH Radio"
    biz_dept    = "DPE"
  }

  map_migrated = "d-server-00fyc0pr7gc8hv"
}



resource "aws_security_group" "asg" {
  name        = "asg"
  description = "Allow inbound traffic"
  vpc_id      = "asdf"

  ingress {
    description = "Ingress from HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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

  tags = {
    Name = "allow_tls"
  }
}

