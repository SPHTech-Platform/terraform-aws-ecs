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

# module "ecs_cpu_autoscaling_policy" {
#   # for_each = { for k, v in local.service_map : k => v if v.service_scaling }

#   source = "../autoscaling-policy"

#   name                             = var.name
#   enable_ecs_cpu_based_autoscaling = true
#   min_capacity                     = var.min_capacity
#   max_capacity                     = var.max_capacity
#   ecs_cluster_name                 = module.cluster.ecs_cluster_name
#   # ecs_service_name                 = module.ecs_service[each.key].ecs_service_name
#   ecs_service_name                 = module.ecs_service[each.key].ecs_service_name
#   target_cpu_value                 = var.target_cpu_value
# }

module "cluster" {
  source = "../cluster"

  name                              = var.name
  link_ecs_to_asg_capacity_provider = var.link_ecs_to_asg_capacity_provider
  asg_arn                           = module.autoscaling_group.autoscaling_group_arn

  tags = var.tags
}

# module "service" {
#   source = "../service"
# }

# module "service_discovery" {
#   source = "./service-discovery"
# }













# locals {
#   service_map = {
#     nextjs = {
#       create          = true
#       service_scaling = false
#       container_definitions = jsonencode([
#         module.container_drop_resolver_dcx.json_map_object,
#         module.container_drop_resolver_print.json_map_object,
#       ])
#       task_cpu      = var.task_cpu
#       task_memory   = var.task_memory
#       desired_count = var.desired_count
#       ecs_load_balancers = [
#         {
#           target_group_arn = element(module.alb.target_group_arns, 1),
#           container_name   = "drop-resolver-dcx",
#           container_port   = "8095"
#         },
#         {
#           target_group_arn = element(module.alb.target_group_arns, 2),
#           container_name   = "drop-resolver-print",
#           container_port   = "8096"
#         },
#       ]
#     }
#     wordpress = {
#       create          = true
#       service_scaling = true
#       container_definitions = jsonencode([
#         module.container_cook.json_map_object,
#       ])
#       task_cpu      = var.task_cpu
#       task_memory   = var.task_memory
#       desired_count = var.desired_count
#       ecs_load_balancers = [
#         {
#           target_group_arn = element(module.alb.target_group_arns, 0),
#           container_name   = "cook",
#           container_port   = "8101"
#         },
#       ]
#     }
#     topdrawer = {
#       create          = true
#       service_scaling = true
#       container_definitions = jsonencode([
#         module.container_topdrawer.json_map_object,
#       ])
#       task_cpu      = var.task_cpu
#       task_memory   = var.task_memory
#       desired_count = var.desired_count
#       ecs_load_balancers = [
#         {
#           target_group_arn = element(module.alb.target_group_arns, 4),
#           container_name   = "topdrawer",
#           container_port   = "8082"
#         },
#       ]
#     }
#     preview = {
#       create          = true
#       service_scaling = true
#       container_definitions = jsonencode([
#         module.container_preview.json_map_object,
#       ])
#       task_cpu      = var.task_cpu
#       task_memory   = var.task_memory
#       desired_count = var.desired_count
#       ecs_load_balancers = [
#         {
#           target_group_arn = element(module.alb.target_group_arns, 3),
#           container_name   = "preview",
#           container_port   = "8085"
#         },
#       ]
#     }
#     graphics_convert = {
#       create          = true
#       service_scaling = false
#       container_definitions = jsonencode([
#         module.container_graphics_convert.json_map_object,
#       ])
#       task_cpu           = var.task_cpu
#       task_memory        = var.task_memory
#       desired_count      = var.desired_count
#       ecs_load_balancers = []
#     }
#   }
# }

# module "ecs_service" {
#   for_each = { for k, v in local.service_map : k => v if v.create }

#   source                = "./modules/service"
#   name                  = format("%s-editorial-%s-%s", var.aws_app_prefix, replace(each.key, "_", "-"), var.aws_env)
#   cluster_id            = module.ecs_cluster.ecs_cluster_id
#   container_definitions = each.value.container_definitions
#   task_cpu              = each.value.task_cpu
#   task_memory           = each.value.task_memory
#   execution_role_arn    = var.execution_role_arn
#   task_role_arn         = var.task_role_arn
#   desired_count         = each.value.desired_count
#   subnets               = var.ecs_subnets
#   security_groups       = var.ecs_security_groups

#   ecs_load_balancers = each.value.ecs_load_balancers
#   tags               = { "Name" : var.name }
# }

