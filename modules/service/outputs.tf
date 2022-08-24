output "ecs_service_arn" {
  description = "ARN of the ECS service"
  value       = try(aws_ecs_service.this.id, "")
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = try(aws_ecs_service.this.name, "")
}
