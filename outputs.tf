output "ecs_cluster_kms_arn" {
  description = "The AWS Key Management Service key ID to encrypt the data between the local client and the container"
  value       = try(module.cluster.ecs_cluster_kms_arn, "")
}

output "ecs_cluster_id" {
  description = "ID of the ECS Cluster"
  value       = try(aws_ecs_cluster.this.id, "")
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS Cluster"
  value       = try(aws_ecs_cluster.this.arn, "")
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = try(aws_ecs_cluster.this.name, "")
}

output "ecs_service_arn" {
  description = "ARN of the ECS service"
  value       = try(aws_ecs_service.this.id, "")
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = try(aws_ecs_service.this.name, "")
}

output "aws_ecs_task_definition" {
  description = "ARN of the ECS service"
  value       = try(aws_ecs_task_definition.this.arn, "")
}
