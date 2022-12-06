module "fargate_cluster" {
  source = "../../"

  name             = "fargate-example"
  launch_type      = "FARGATE"
  platform_version = "1.4.0"

  service_task_execution_role_arn = module.ecs_task_execution_role.iam_role_arn
  service_task_role_arn           = module.ecs_task_role.iam_role_arn
  service_map                     = local.service_map
  service_subnets                 = data.aws_subnets.private.ids
  service_security_groups         = [aws_security_group.ecs_sg.id]
}

module "ecs_task_execution_role" {
  source = "../../modules/iam"

  role_name             = "ecs-task-execution-role-${var.name}"
  trusted_role_services = ["ecs-tasks.amazonaws.com"]
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
}

module "ecs_task_role" {
  source = "../../modules/iam/"

  role_name             = "ecs-task-role-${var.name}"
  trusted_role_services = ["ecs-tasks.amazonaws.com"]
  policy                = data.aws_iam_policy_document.task_custom_policy.json
  policy_name           = "ecs-task-policy-${var.name}"
}