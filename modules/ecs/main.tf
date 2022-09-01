module "autoscaling_group" {
  source = "../autoscaling-group"

  create = var.asg_create

  name          = var.asg_name
  instance_name = var.asg_instance_name

  min_size                        = var.asg_min_size
  max_size                        = var.asg_max_size
  desired_capacity                = var.asg_desired_capacity
  ignore_desired_capacity_changes = var.asg_ignore_desired_capacity_changes
  wait_for_capacity_timeout       = var.asg_wait_for_capacity_timeout
  protect_from_scale_in           = var.asg_protect_from_scale_in
  health_check_type               = var.asg_health_check_type

  launch_template_description = var.asg_launch_template_description
  image_id                    = var.asg_image_id
  instance_type               = var.asg_instance_type
  ebs_optimized               = var.asg_ebs_optimized
  enable_monitoring           = var.asg_enable_monitoring
  enabled_metrics             = var.asg_enabled_metrics
  user_data_base64            = var.asg_user_data_base64
  volume_size                 = var.asg_volume_size

  iam_instance_profile_arn = var.asg_iam_instance_profile_arn

  subnets                           = var.asg_subnets
  network_interface_security_groups = var.asg_network_interface_security_groups
  placement                         = var.asg_placement

  tags = var.tags
}

module "cluster" {
  source = "../cluster"

  name                              = var.name
  link_ecs_to_asg_capacity_provider = var.link_ecs_to_asg_capacity_provider
  asg_arn                           = module.autoscaling_group.autoscaling_group_arn

  tags = var.tags
}

# module "service_cpu_autoscaling_policy" {
#   # for_each = { for k, v in local.service_map : k => v if v.service_scaling }

#   source = "../autoscaling-policy"

#   name                             = var.name
#   enable_ecs_cpu_based_autoscaling = true
#   min_capacity                     = var.min_capacity
#   max_capacity                     = var.max_capacity
#   ecs_cluster_name                 = module.cluster.ecs_cluster_name
#   ecs_service_name                 = module.service[each.key].ecs_service_name
#   target_cpu_value                 = var.target_cpu_value
# }

module "service" {
  for_each = { for k, v in var.service_map : k => v if v.create }

  source                = "../service"
  name                  = format("%s-%s", var.name, replace(each.key, "_", "-"))
  cluster_id            = module.cluster.ecs_cluster_id
  container_definitions = each.value.service_container_definitions
  task_cpu              = each.value.service_task_cpu
  task_memory           = each.value.service_task_memory
  desired_count         = each.value.service_desired_count
  execution_role_arn    = var.service_task_execution_role_arn
  task_role_arn         = var.service_task_role_arn
  subnets               = var.service_subnets
  security_groups       = var.service_security_groups

  # ecs_load_balancers = each.value.ecs_load_balancers
  tags = { "Name" : var.name }

}


# module "service_discovery" {
#   source = "./service-discovery"
# }