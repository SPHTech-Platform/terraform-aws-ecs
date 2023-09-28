output "ecs_service_arn" {
  description = "ARN of the ECS service"
  value       = try(aws_ecs_service.this[0].id, aws_ecs_service.ignore_taskdef[0].id, "")
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = try(aws_ecs_service.this[0].name, aws_ecs_service.ignore_taskdef[0].name, "")
}
output "aws_ecs_task_definition" {
  description = "ARN of the ECS service"
  value       = try(aws_ecs_task_definition.this.arn, "")
}
