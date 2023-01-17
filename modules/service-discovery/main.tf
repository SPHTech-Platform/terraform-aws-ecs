resource "aws_service_discovery_private_dns_namespace" "this" {
  count = var.enable_service_discovery ? 1 : 0

  name        = var.internal_dns_name
  description = "Private DNS namespace for ECS services"
  vpc         = var.vpc_id
}

resource "aws_service_discovery_service" "this" {
  for_each = var.enable_service_discovery ? toset(var.service_names) : []

  name = each.value

  dns_config {
    namespace_id = element(aws_service_discovery_private_dns_namespace.this[*].id, 0)

    dns_records {
      ttl  = var.service_discovery_record_ttl
      type = var.service_discovery_record_type
    }

    routing_policy = var.service_discovery_routing_policy
  }

  health_check_custom_config {
    failure_threshold = var.service_discovery_health_check_failure_threshold
  }
}
