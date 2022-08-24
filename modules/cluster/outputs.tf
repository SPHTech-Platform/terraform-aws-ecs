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
