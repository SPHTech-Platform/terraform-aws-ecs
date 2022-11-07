<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.ecs_service_cpu_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.ecs_service_memory_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.ecs_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_autoscaling_policy.asg_cpu_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_autoscaling_policy.asg_memory_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling_group_name"></a> [autoscaling\_group\_name](#input\_autoscaling\_group\_name) | Autoscaling Group to apply the policy | `string` | `null` | no |
| <a name="input_cpu_statistics"></a> [cpu\_statistics](#input\_cpu\_statistics) | Statistics to use: [Maximum, SampleCount, Sum, Minimum, Average]. Note that resolution used in alarm generated is 1 minute. | `string` | `"Average"` | no |
| <a name="input_cpu_threshold"></a> [cpu\_threshold](#input\_cpu\_threshold) | Keep the ECS Cluster CPU Reservation around this value. Value is in percentage (0..100). Must be specified if cpu based autoscaling is enabled. | `number` | `null` | no |
| <a name="input_disable_scale_in"></a> [disable\_scale\_in](#input\_disable\_scale\_in) | Disable scale-in action, defaults to false | `bool` | `false` | no |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | ECS Cluster name to apply on (NOT ARN) | `string` | n/a | yes |
| <a name="input_ecs_service_name"></a> [ecs\_service\_name](#input\_ecs\_service\_name) | ECS Service name to apply on (NOT ARN) | `string` | n/a | yes |
| <a name="input_enable_asg_cpu_based_autoscaling"></a> [enable\_asg\_cpu\_based\_autoscaling](#input\_enable\_asg\_cpu\_based\_autoscaling) | Enable Autoscaling based on ECS Cluster CPU Reservation | `bool` | `false` | no |
| <a name="input_enable_asg_memory_based_autoscaling"></a> [enable\_asg\_memory\_based\_autoscaling](#input\_enable\_asg\_memory\_based\_autoscaling) | Enable Autoscaling based on ECS Cluster Memory Reservation | `bool` | `false` | no |
| <a name="input_enable_ecs_cpu_based_autoscaling"></a> [enable\_ecs\_cpu\_based\_autoscaling](#input\_enable\_ecs\_cpu\_based\_autoscaling) | Enable Autoscaling based on ECS Service CPU Usage | `bool` | `false` | no |
| <a name="input_enable_ecs_memory_based_autoscaling"></a> [enable\_ecs\_memory\_based\_autoscaling](#input\_enable\_ecs\_memory\_based\_autoscaling) | Enable Autoscaling based on ECS Service Memory Usage | `bool` | `false` | no |
| <a name="input_max_capacity"></a> [max\_capacity](#input\_max\_capacity) | Maximum capacity of ECS autoscaling target, cannot be less than min\_capacity | `number` | n/a | yes |
| <a name="input_memory_statistics"></a> [memory\_statistics](#input\_memory\_statistics) | Statistics to use: [Maximum, SampleCount, Sum, Minimum, Average]. Note that resolution used in alarm generated is 1 minute. | `string` | `"Average"` | no |
| <a name="input_memory_threshold"></a> [memory\_threshold](#input\_memory\_threshold) | Keep the ECS Cluster Memory Reservation around this value. Value is in percentage (0..100). Must be specified if memory based autoscaling is enabled. | `number` | `null` | no |
| <a name="input_min_capacity"></a> [min\_capacity](#input\_min\_capacity) | Minimum capacity of ECS autoscaling target, cannot be more than max\_capacity | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the ECS Policy created, will appear in Auto Scaling under Service in ECS | `string` | n/a | yes |
| <a name="input_scale_in_cooldown"></a> [scale\_in\_cooldown](#input\_scale\_in\_cooldown) | Time between scale in action | `number` | `300` | no |
| <a name="input_scale_out_cooldown"></a> [scale\_out\_cooldown](#input\_scale\_out\_cooldown) | Time between scale out action | `number` | `300` | no |
| <a name="input_target_cpu_value"></a> [target\_cpu\_value](#input\_target\_cpu\_value) | Autoscale when CPU Usage value over the specified value. Must be specified if `enable_cpu_based_autoscaling` is `true`. | `number` | `null` | no |
| <a name="input_target_memory_value"></a> [target\_memory\_value](#input\_target\_memory\_value) | Autoscale when Memory Usage value over the specified value. Must be specified if `enable_memory_based_autoscaling` is `true`. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cpu_autoscaling_arn"></a> [cpu\_autoscaling\_arn](#output\_cpu\_autoscaling\_arn) | The ARN assigned by AWS to the scaling policy. |
| <a name="output_cpu_autoscaling_asg_name"></a> [cpu\_autoscaling\_asg\_name](#output\_cpu\_autoscaling\_asg\_name) | The scaling policy's assigned autoscaling group. |
| <a name="output_cpu_autoscaling_name"></a> [cpu\_autoscaling\_name](#output\_cpu\_autoscaling\_name) | The scaling policy's name. |
| <a name="output_cpu_autoscaling_policy_type"></a> [cpu\_autoscaling\_policy\_type](#output\_cpu\_autoscaling\_policy\_type) | The scaling policy's type. |
| <a name="output_cpu_policy_arn"></a> [cpu\_policy\_arn](#output\_cpu\_policy\_arn) | ARN of the autoscaling policy generated. |
| <a name="output_cpu_policy_name"></a> [cpu\_policy\_name](#output\_cpu\_policy\_name) | Name of the autoscaling policy generated |
| <a name="output_cpu_policy_type"></a> [cpu\_policy\_type](#output\_cpu\_policy\_type) | Policy type of the autoscaling policy generated. Always TargetTrackingScaling |
| <a name="output_memory_autoscaling_arn"></a> [memory\_autoscaling\_arn](#output\_memory\_autoscaling\_arn) | The ARN assigned by AWS to the scaling policy. |
| <a name="output_memory_autoscaling_asg_name"></a> [memory\_autoscaling\_asg\_name](#output\_memory\_autoscaling\_asg\_name) | The scaling policy's assigned autoscaling group. |
| <a name="output_memory_autoscaling_name"></a> [memory\_autoscaling\_name](#output\_memory\_autoscaling\_name) | The scaling policy's name. |
| <a name="output_memory_autoscaling_policy_type"></a> [memory\_autoscaling\_policy\_type](#output\_memory\_autoscaling\_policy\_type) | The scaling policy's type. |
| <a name="output_memory_policy_arn"></a> [memory\_policy\_arn](#output\_memory\_policy\_arn) | ARN of the autoscaling policy generated. |
| <a name="output_memory_policy_name"></a> [memory\_policy\_name](#output\_memory\_policy\_name) | Name of the autoscaling policy generated |
| <a name="output_memory_policy_type"></a> [memory\_policy\_type](#output\_memory\_policy\_type) | Policy type of the autoscaling policy generated. Always TargetTrackingScaling |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
