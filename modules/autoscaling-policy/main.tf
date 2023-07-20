resource "aws_appautoscaling_target" "ecs_target" {
  count = var.enable_ecs_cpu_based_autoscaling || var.enable_ecs_memory_based_autoscaling ? 1 : 0

  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
  resource_id        = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_service_cpu_policy" {
  count = var.enable_ecs_cpu_based_autoscaling ? 1 : 0

  name               = "${var.name}-service-cpu"
  resource_id        = aws_appautoscaling_target.ecs_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[0].service_namespace
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value       = var.target_cpu_value
    disable_scale_in   = var.disable_scale_in
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

resource "aws_appautoscaling_policy" "ecs_service_memory_policy" {
  count = var.enable_ecs_memory_based_autoscaling ? 1 : 0

  name               = "${var.name}-service-memory"
  resource_id        = aws_appautoscaling_target.ecs_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[0].service_namespace
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value       = var.target_memory_value
    disable_scale_in   = var.disable_scale_in
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}

resource "aws_autoscaling_policy" "asg_cpu_autoscaling" {
  count = var.enable_asg_cpu_based_autoscaling ? 1 : 0

  name                   = "${var.name}-asg-cpu"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = var.autoscaling_group_name

  target_tracking_configuration {
    target_value     = var.cpu_threshold
    disable_scale_in = var.disable_scale_in

    customized_metric_specification {
      metric_name = "CPUReservation"
      namespace   = "AWS/ECS"
      statistic   = var.cpu_statistics

      metric_dimension {
        name  = "ClusterName"
        value = var.ecs_cluster_name
      }
    }
  }
}

resource "aws_autoscaling_policy" "asg_memory_autoscaling" {
  count = var.enable_asg_memory_based_autoscaling ? 1 : 0

  name                   = "${var.name}-asg-memory"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = var.autoscaling_group_name

  target_tracking_configuration {
    target_value     = var.memory_threshold
    disable_scale_in = var.disable_scale_in

    customized_metric_specification {
      metric_name = "MemoryReservation"
      namespace   = "AWS/ECS"
      statistic   = var.memory_statistics

      metric_dimension {
        name  = "ClusterName"
        value = var.ecs_cluster_name
      }
    }
  }
}

resource "aws_appautoscaling_scheduled_action" "this" {
  for_each = { for k, v in var.autoscaling_scheduled_actions : k => v if lookup(v, "create", true) }

  name               = "${var.name}-scheduler"
  service_namespace  = aws_appautoscaling_target.ecs_target[0].service_namespace
  resource_id        = aws_appautoscaling_target.ecs_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[0].scalable_dimension

  scalable_target_action {
    min_capacity = each.value.min_capacity
    max_capacity = each.value.max_capacity
  }

  schedule   = each.value.schedule
  start_time = try(each.value.start_time, null)
  end_time   = try(each.value.end_time, null)
  timezone   = try(each.value.timezone, null)
}
