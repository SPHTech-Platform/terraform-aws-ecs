# terraform {
#   experiments = [module_variable_optional_attrs]
# }
locals {
  launch_types           = ["EC2", "FARGATE"]
  platform_versions      = ["LATEST", "1.4.0", "1.3.0"]
  network_mode_types     = ["awsvpc", "none", "bridge", "host"]
  deployment_controllers = ["ECS", "CODE_DEPLOY"]

  volumes = concat(var.docker_volumes, var.efs_volumes)
}

resource "aws_ecs_task_definition" "this" {
  family                   = "taskdef-${var.name}"
  container_definitions    = var.container_definitions
  requires_compatibilities = [var.launch_type]
  cpu                      = var.launch_type == "FARGATE" ? var.task_cpu : null
  memory                   = var.launch_type == "FARGATE" ? var.task_memory : null
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  network_mode             = var.network_mode

  dynamic "volume" {
    for_each = local.volumes

    content {
      host_path = lookup(volume.value, "host_path", null)
      name      = volume.value.name

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
          scope         = lookup(docker_volume_configuration.value, "scope", null)
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = lookup(volume.value, "efs_volume_configuration", [])

        content {
          file_system_id          = lookup(efs_volume_configuration.value, "file_system_id", null)
          root_directory          = lookup(efs_volume_configuration.value, "root_directory", null)
          transit_encryption      = lookup(efs_volume_configuration.value, "transit_encryption", "ENABLED")
          transit_encryption_port = lookup(efs_volume_configuration.value, "transit_encryption_port", 2999)
          dynamic "authorization_config" {
            for_each = lookup(efs_volume_configuration.value, "authorization_config", [])
            content {
              access_point_id = lookup(authorization_config.value, "access_point_id", null)
              iam             = lookup(authorization_config.value, "iam", null)
            }
          }
        }
      }
    }
  }

  dynamic "placement_constraints" {
    for_each = var.task_placement_constraints

    content {
      type       = placement_constraints.value.type
      expression = lookup(placement_constraints.value, "expression", null)
    }
  }

  tags = var.tags

}

# Create a data source to pull the latest active revision from
data "aws_ecs_task_definition" "this" {
  task_definition = aws_ecs_task_definition.this.family
  depends_on      = [aws_ecs_task_definition.this] # ensures at least one task def exists
}

resource "aws_ecs_service" "this" {
  name    = var.name
  cluster = var.cluster_id

  # Use latest active revision
  task_definition = "${aws_ecs_task_definition.this.family}:${max(
    aws_ecs_task_definition.this.revision,
    data.aws_ecs_task_definition.this.revision,
  )}"

  launch_type             = var.launch_type
  platform_version        = var.launch_type == "FARGATE" ? var.platform_version : null
  desired_count           = var.desired_count
  enable_ecs_managed_tags = var.enable_ecs_managed_tags
  propagate_tags          = var.propagate_tags

  deployment_controller {
    type = var.deployment_controller_type
  }

  dynamic "service_registries" {
    for_each = var.service_registries

    content {
      registry_arn   = service_registries.value.registry_arn
      port           = lookup(service_registries.value, "port", null)
      container_name = lookup(service_registries.value, "container_name", null)
      container_port = lookup(service_registries.value, "container_port", null)
    }
  }


  dynamic "ordered_placement_strategy" {
    for_each = var.ordered_placement_strategy

    content {
      type  = ordered_placement_strategy.value.type
      field = lookup(ordered_placement_strategy.value, "field", null)
    }
  }

  dynamic "placement_constraints" {
    for_each = var.service_placement_constraints

    content {
      type       = placement_constraints.value.type
      expression = lookup(placement_constraints.value, "expression", null)
    }
  }

  dynamic "load_balancer" {
    for_each = var.ecs_load_balancers

    content {
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
      elb_name         = lookup(load_balancer.value, "elb_name", null)
      target_group_arn = lookup(load_balancer.value, "target_group_arn", null)
    }
  }

  dynamic "network_configuration" {
    for_each = var.network_mode == "awsvpc" ? [1] : []

    content {
      subnets          = var.subnets
      security_groups  = var.security_groups
      assign_public_ip = var.assign_public_ip
    }
  }

  tags = var.tags

}