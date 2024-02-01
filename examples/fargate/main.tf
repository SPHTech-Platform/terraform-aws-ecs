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

  capacity_providers                 = ["FARGATE", "FARGATE_SPOT"]
  default_capacity_provider_strategy = [
    { "capacity_provider" : "FARGATE_SPOT", "weight" : 2, "base" : 0 },
    { "capacity_provider" : "FARGATE", "weight" : 1, "base" : 1 }
  ]
}

module "ecs_task_execution_role" {
  source = "../../modules/iam"

  role_name             = "ecs-task-execution-role-${var.name}"
  trusted_role_services = ["ecs-tasks.amazonaws.com"]
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
  policy      = data.aws_iam_policy_document.execution_custom_policy.json
  policy_name = "ecs-task-execution-policy-${var.name}"
}

module "ecs_task_role" {
  source = "../../modules/iam/"

  role_name             = "ecs-task-role-${var.name}"
  trusted_role_services = ["ecs-tasks.amazonaws.com"]
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess",
  ]
  policy      = data.aws_iam_policy_document.task_ecs_exec_policy.json
  policy_name = "ecs-task-policy-${var.name}"
}
