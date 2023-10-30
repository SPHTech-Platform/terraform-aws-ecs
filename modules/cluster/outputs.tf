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

output "ecs_cluster_kms_arn" {
  description = "The AWS Key Management Service key ID to encrypt the data between the local client and the container"
  value       = try(aws_kms_key.cluster.arn, "")
}

output "ecs_cloudwatch_log_group_name" {
  description = "The cloudwatch log group to be used by the cluster"
  value       = try(aws_cloudwatch_log_group.this.*.name, "")
}


