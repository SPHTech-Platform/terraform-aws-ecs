output "namespace_id" {
  description = "The ID of the namespace that you want to use to create the service."
  value       = aws_service_discovery_private_dns_namespace.this.*.id
}

output "namespace_arn" {
  description = "arn of the namespace"
  value       = aws_service_discovery_private_dns_namespace.this.*.arn
}

output "service_ids" {
  description = "map of service ids"
  value       = try(zipmap(values(aws_service_discovery_service.this)[*]["name"], values(aws_service_discovery_service.this)[*]["id"]), {})
}

output "service_arns" {
  description = "map of service arns"
  value       = try(zipmap(values(aws_service_discovery_service.this)[*]["name"], values(aws_service_discovery_service.this)[*]["arn"]), {})
}
