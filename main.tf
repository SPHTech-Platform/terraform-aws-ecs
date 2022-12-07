module "autoscaling_group" {
  source = "./modules/autoscaling-group"

  create                 = var.asg_create
  create_launch_template = var.create_launch_template
  launch_type            = var.launch_type

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
  instance_market_options     = var.asg_instance_market_options

  iam_instance_profile_arn = var.asg_iam_instance_profile_arn

  subnets                           = var.asg_subnets
  network_interface_security_groups = var.asg_network_interface_security_groups
  placement                         = var.asg_placement
}

module "cluster" {
  source = "./modules/cluster"

  name                              = var.name
  link_ecs_to_asg_capacity_provider = var.link_ecs_to_asg_capacity_provider
  asg_arn                           = module.autoscaling_group.autoscaling_group_arn
}

module "service" {
  for_each = { for k, v in var.service_map : k => v if lookup(v, "create", true) }

  source = "./modules/service"

  name                  = format("%s-%s", var.name, replace(each.key, "_", "-"))
  cluster_id            = module.cluster.ecs_cluster_id
  container_definitions = each.value.service_container_definitions
  launch_type           = var.launch_type
  task_cpu              = each.value.service_task_cpu
  task_memory           = each.value.service_task_memory
  desired_count         = each.value.service_desired_count
  execution_role_arn    = lookup(each.value, "execution_role_arn", var.service_task_execution_role_arn)
  task_role_arn         = lookup(each.value, "task_role_arn", var.service_task_role_arn)
  subnets               = var.service_subnets
  security_groups       = var.service_security_groups

  deployment_maximum_percent         = var.service_deployment_maximum_percent
  deployment_minimum_healthy_percent = var.service_deployment_minimum_healthy_percent

  ecs_load_balancers = lookup(each.value, "ecs_load_balancers", [])

  docker_volumes   = lookup(each.value, "docker_volumes", [])
  assign_public_ip = var.assign_public_ip
}

module "service_cpu_autoscaling_policy" {
  for_each = { for k, v in var.service_map : k => v if lookup(v, "service_scaling", false) }

  source = "./modules/autoscaling-policy"

  name                             = format("%s-%s", var.name, replace(each.key, "_", "-"))
  enable_ecs_cpu_based_autoscaling = true
  min_capacity                     = var.service_min_capacity
  max_capacity                     = var.service_max_capacity
  target_cpu_value                 = var.service_target_cpu_value
  ecs_cluster_name                 = module.cluster.ecs_cluster_name
  ecs_service_name                 = module.service[each.key].ecs_service_name
}
