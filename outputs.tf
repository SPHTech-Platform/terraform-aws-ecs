output "ecs_cluster_kms_arn" {
  description = "The AWS Key Management Service key ID to encrypt the data between the local client and the container"
  value       = try(module.cluster.ecs_cluster_kms_arn, "")
}

output "ecs_cluster_id" {
  description = "ID of the ECS Cluster"
  value       = try(module.cluster.ecs_cluster_id, "")
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS Cluster"
  value       = try(module.cluster.ecs_cluster_arn, "")
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = try(module.cluster.ecs_cluster_name, "")
}

output "ecs_service_arn" {
  description = "ARN of the ECS service"
  value       = try(module.cluster.ecs_service_arn, "")
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = try(module.cluster.ecs_service_name, "")
}

output "aws_ecs_task_definition" {
  description = "ARN of the ECS service"
  value       = try(module.cluster.aws_ecs_task_definition, "")
}

output "ecs_cloudwatch_log_group_name" {
  description = "The cloudwatch log group to be used by the cluster"
  value       = try(module.cluster.ecs_cloudwatch_log_group_name, "")
}
