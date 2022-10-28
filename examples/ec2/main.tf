module "ecs_cluster" {
  source = "../../"

  name                              = var.name
  link_ecs_to_asg_capacity_provider = true

  # Auto scaling group
  asg_create                            = true
  asg_name                              = var.name
  asg_instance_name                     = var.name
  asg_min_size                          = "2"
  asg_max_size                          = "4"
  asg_desired_capacity                  = "2"
  asg_protect_from_scale_in             = true
  asg_subnets                           = data.aws_subnets.private.ids
  asg_network_interface_security_groups = [aws_security_group.ecs_sg.id]
  asg_image_id                          = data.aws_ssm_parameter.bottlerocket_ami.value
  asg_instance_type                     = "m5.2xlarge"
  asg_volume_size                       = "30"
  asg_iam_instance_profile_arn          = module.ecs_instance_role.iam_instance_profile_arn
  asg_user_data_base64                  = base64encode(local_file.user_data.content)

  # Service
  service_map                     = local.service_map
  service_task_execution_role_arn = module.ecs_task_execution_role.iam_role_arn
  service_task_role_arn           = module.ecs_task_role.iam_role_arn
  service_subnets                 = data.aws_subnets.private.ids
  service_security_groups         = [aws_security_group.ecs_sg.id]
}

module "ecs_instance_role" {
  source = "../../modules/iam"

  role_name             = "ecs-instance-role-${var.name}"
  trusted_role_services = ["ec2.amazonaws.com"]
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  ]
  create_user             = false
  create_instance_profile = true
}

module "ecs_task_execution_role" {
  source = "../../modules/iam"

  role_name             = "ecs-task-execution-role-${var.name}"
  trusted_role_services = ["ecs-tasks.amazonaws.com"]
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
  create_user             = false
  create_instance_profile = false
  policy                  = data.aws_iam_policy_document.execution_custom_policy.json
  policy_name             = "ecs-task-execution-policy-${var.name}"
}

module "ecs_task_role" {
  source = "../../modules/iam/"

  role_name               = "ecs-task-role-${var.name}-${local.stack}"
  trusted_role_services   = ["ecs-tasks.amazonaws.com"]
  create_user             = false
  create_instance_profile = false
  policy                  = data.aws_iam_policy_document.task_custom_policy.json
  policy_name             = "ecs-task-policy-${var.name}-${local.stack}"
}

resource "local_file" "user_data" {
  content  = <<-EOF
    [settings.ecs]
    cluster = "ecs-${var.name}"
  EOF
  filename = "${path.module}/user_data.toml"
}
