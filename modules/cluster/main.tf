locals {
  log_group_name = var.log_group_name == "" ? "/aws/ecs/ecs-${var.name}" : var.log_group_name
  asg_cap_name   = "asg-ecs-${var.name}"
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.create_log_group ? 1 : 0

  name              = local.log_group_name
  retention_in_days = var.log_retention
  kms_key_id        = aws_kms_key.cloudwatch.arn
  tags              = merge(var.tags, { "Name" = local.log_group_name })
}

resource "aws_kms_key" "cloudwatch" {
  description         = "Key for ECS log encryption"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.cloudwatch_logs_allow_kms.json
}


resource "aws_kms_key" "cluster" {
  #checkov:skip=CKV2_AWS_64:Accept risk of no KMS key policy

  description             = "Key for data between the local client and the container"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}

resource "aws_ecs_capacity_provider" "this" {
  count = var.link_ecs_to_asg_capacity_provider ? 1 : 0

  name = local.asg_cap_name
  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.asg_arn
    managed_termination_protection = var.termination_protection ? "ENABLED" : "DISABLED"
    managed_scaling {
      maximum_scaling_step_size = var.scaling_max_step_size
      minimum_scaling_step_size = var.scaling_min_step_size
      status                    = var.managed_scaling ? "ENABLED" : "DISABLED"
      target_capacity           = var.scaling_target_capacity
    }
  }
  tags = merge(var.tags, { "Name" : local.asg_cap_name })
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  count = var.create_capacity_provider ? 1 : 0

  cluster_name       = aws_ecs_cluster.this.name
  capacity_providers = var.link_ecs_to_asg_capacity_provider ? [try(aws_ecs_capacity_provider.this[0].name, null)] : var.capacity_providers

  dynamic "default_capacity_provider_strategy" {
    for_each = length(var.asg_arn) == 0 ? var.default_capacity_provider_strategy : []

    iterator = strategy
    content {
      capacity_provider = strategy.value["capacity_provider"]
      weight            = lookup(strategy.value, "weight", null)
      base              = lookup(strategy.value, "base", null)
    }
  }
}

resource "aws_ecs_cluster" "this" {
  name = format("ecs-%s", var.name)
  setting {
    name  = "containerInsights"
    value = var.ecs_container_insights ? "enabled" : "disabled"
  }

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.cluster.arn
      logging    = "OVERRIDE"
      log_configuration {
        cloud_watch_encryption_enabled = var.ecs_encrypt_logs
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.this[0].name
      }
    }
  }
  tags = merge(var.tags, { "Name" : var.ecs_cluster_name })
}
