output "cpu_autoscaling_arn" {
  description = "The ARN assigned by AWS to the scaling policy."
  value       = join("", aws_autoscaling_policy.asg_cpu_autoscaling[*].arn)
}

output "cpu_autoscaling_name" {
  description = "The scaling policy's name."
  value       = join("", aws_autoscaling_policy.asg_cpu_autoscaling[*].name)
}

output "cpu_autoscaling_asg_name" {
  description = "The scaling policy's assigned autoscaling group."
  value       = join("", aws_autoscaling_policy.asg_cpu_autoscaling[*].autoscaling_group_name)
}

output "cpu_autoscaling_policy_type" {
  description = "The scaling policy's type."
  value       = join("", aws_autoscaling_policy.asg_cpu_autoscaling[*].policy_type)
}

output "memory_autoscaling_arn" {
  description = "The ARN assigned by AWS to the scaling policy."
  value       = join("", aws_autoscaling_policy.asg_memory_autoscaling[*].arn)
}

output "memory_autoscaling_name" {
  description = "The scaling policy's name."
  value       = join("", aws_autoscaling_policy.asg_memory_autoscaling[*].name)
}

output "memory_autoscaling_asg_name" {
  description = "The scaling policy's assigned autoscaling group."
  value       = join("", aws_autoscaling_policy.asg_memory_autoscaling[*].autoscaling_group_name)
}

output "memory_autoscaling_policy_type" {
  description = "The scaling policy's type."
  value       = join("", aws_autoscaling_policy.asg_memory_autoscaling[*].policy_type)
}

output "cpu_policy_arn" {
  description = "ARN of the autoscaling policy generated."
  value       = concat(aws_appautoscaling_policy.ecs_service_cpu_policy[*].arn, [""])
}

output "cpu_policy_name" {
  description = "Name of the autoscaling policy generated"
  value       = concat(aws_appautoscaling_policy.ecs_service_cpu_policy[*].name, [""])
}

output "cpu_policy_type" {
  description = "Policy type of the autoscaling policy generated. Always TargetTrackingScaling"
  value       = concat(aws_appautoscaling_policy.ecs_service_cpu_policy[*].policy_type, [""])
}

output "memory_policy_arn" {
  description = "ARN of the autoscaling policy generated."
  value       = concat(aws_appautoscaling_policy.ecs_service_memory_policy[*].arn, [""])
}

output "memory_policy_name" {
  description = "Name of the autoscaling policy generated"
  value       = concat(aws_appautoscaling_policy.ecs_service_memory_policy[*].name, [""])
}

output "memory_policy_type" {
  description = "Policy type of the autoscaling policy generated. Always TargetTrackingScaling"
  value       = concat(aws_appautoscaling_policy.ecs_service_memory_policy[*].policy_type, [""])
}
