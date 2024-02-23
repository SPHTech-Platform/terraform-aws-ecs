<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.38.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_service_discovery_private_dns_namespace.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_private_dns_namespace) | resource |
| [aws_service_discovery_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_service_discovery"></a> [enable\_service\_discovery](#input\_enable\_service\_discovery) | Whether to enable service discovery for tasks | `bool` | `true` | no |
| <a name="input_internal_dns_name"></a> [internal\_dns\_name](#input\_internal\_dns\_name) | Internal DNS name, required when enabling service discovery | `string` | `""` | no |
| <a name="input_service_discovery_health_check_failure_threshold"></a> [service\_discovery\_health\_check\_failure\_threshold](#input\_service\_discovery\_health\_check\_failure\_threshold) | The health check failure threshold | `number` | `1` | no |
| <a name="input_service_discovery_record_ttl"></a> [service\_discovery\_record\_ttl](#input\_service\_discovery\_record\_ttl) | The DNS record ttl used in service discovery | `number` | `10` | no |
| <a name="input_service_discovery_record_type"></a> [service\_discovery\_record\_type](#input\_service\_discovery\_record\_type) | The DNS record type used in service discovery | `string` | `"A"` | no |
| <a name="input_service_discovery_routing_policy"></a> [service\_discovery\_routing\_policy](#input\_service\_discovery\_routing\_policy) | The routing policy used in service discovery | `string` | `"MULTIVALUE"` | no |
| <a name="input_service_names"></a> [service\_names](#input\_service\_names) | List of service names to create service discovery | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC identifier | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace_arn"></a> [namespace\_arn](#output\_namespace\_arn) | arn of the namespace |
| <a name="output_namespace_id"></a> [namespace\_id](#output\_namespace\_id) | The ID of the namespace that you want to use to create the service. |
| <a name="output_service_arns"></a> [service\_arns](#output\_service\_arns) | map of service arns |
| <a name="output_service_ids"></a> [service\_ids](#output\_service\_ids) | map of service ids |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
