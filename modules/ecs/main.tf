# module "ssm" {
#   source = "../ssm"

#   standard_tags = var.standard_tags
#   map_migrated  = var.map_migrated
# }

module "autoscaling_group" {
  source = "../autoscaling-group"

  create                            = var.asg_create
  name                              = var.name
  instance_name                     = var.asg_instance_name
  min_size                          = var.asg_min_size
  max_size                          = var.asg_max_size
  desired_capacity                  = var.asg_desired_capacity
  subnets                           = var.asg_subnets
  network_interface_security_groups = var.asg_network_interface_security_groups
  image_id                          = var.asg_image_id
  instance_type                     = var.asg_instance_type
  volume_size                       = var.asg_volume_size
  user_data_base64                  = var.asg_user_data_base64
  iam_instance_profile_arn          = var.asg_iam_instance_profile_arn

  standard_tags = var.standard_tags
  map_migrated  = var.map_migrated
}

# module "autoscaling_policy" {
#   source = "../autoscaling-policy"
# }

module "cluster" {
  source = "../cluster"

  name                              = var.name
  link_ecs_to_asg_capacity_provider = var.link_ecs_to_asg_capacity_provider
  # asg_arn                          = module.asg.autoscaling_group_arn

  # tags
  standard_tags = var.standard_tags
  map_migrated  = var.map_migrated
}

# module "service" {
#   source = "../service"
# }

# module "service_discovery" {
#   source = "./service-discovery"
# }








