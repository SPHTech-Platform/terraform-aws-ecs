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
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_capacity_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_capacity_provider) | resource |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_cluster_capacity_providers.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster_capacity_providers) | resource |
| [aws_kms_key.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cloudwatch_logs_allow_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_arn"></a> [asg\_arn](#input\_asg\_arn) | Autoscaling Group ARN | `string` | `""` | no |
| <a name="input_capacity_providers"></a> [capacity\_providers](#input\_capacity\_providers) | List of short names of one or more capacity providers to associate with the cluster. Valid values also include FARGATE and FARGATE\_SPOT. | `list(string)` | `[]` | no |
| <a name="input_create_capacity_provider"></a> [create\_capacity\_provider](#input\_create\_capacity\_provider) | Specify whether to create autoscaling based capacity provider | `bool` | `true` | no |
| <a name="input_create_log_group"></a> [create\_log\_group](#input\_create\_log\_group) | Whether to create log group | `bool` | `true` | no |
| <a name="input_default_capacity_provider_strategy"></a> [default\_capacity\_provider\_strategy](#input\_default\_capacity\_provider\_strategy) | The capacity provider strategy to use by default for the cluster. Can be one or more. | `list(map(any))` | `[]` | no |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | Name of the ecs cluster | `string` | `null` | no |
| <a name="input_ecs_container_insights"></a> [ecs\_container\_insights](#input\_ecs\_container\_insights) | Whether to enable container insights for ECS cluster | `bool` | `true` | no |
| <a name="input_ecs_encrypt_logs"></a> [ecs\_encrypt\_logs](#input\_ecs\_encrypt\_logs) | Enable encryption for cloudwatch logs | `bool` | `true` | no |
| <a name="input_key_admin_arn"></a> [key\_admin\_arn](#input\_key\_admin\_arn) | Key administrator principal for the KMS key | `string` | `""` | no |
| <a name="input_link_ecs_to_asg_capacity_provider"></a> [link\_ecs\_to\_asg\_capacity\_provider](#input\_link\_ecs\_to\_asg\_capacity\_provider) | Specify whether link ECS to autoscaling group capacity provider | `bool` | `false` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | Provide name for log group | `string` | `""` | no |
| <a name="input_log_retention"></a> [log\_retention](#input\_log\_retention) | Specify log retention in days | `number` | `30` | no |
| <a name="input_managed_scaling"></a> [managed\_scaling](#input\_managed\_scaling) | Specifies whether to enable managed scaling | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the product/project/application | `string` | `""` | no |
| <a name="input_scaling_max_step_size"></a> [scaling\_max\_step\_size](#input\_scaling\_max\_step\_size) | Sets managed scaling max step size | `number` | `10` | no |
| <a name="input_scaling_min_step_size"></a> [scaling\_min\_step\_size](#input\_scaling\_min\_step\_size) | Sets managed scaling min step size | `number` | `1` | no |
| <a name="input_scaling_target_capacity"></a> [scaling\_target\_capacity](#input\_scaling\_target\_capacity) | Sets managed scaling target capacity | `number` | `80` | no |
| <a name="input_service_connect_defaults"></a> [service\_connect\_defaults](#input\_service\_connect\_defaults) | Configures a Service Connect Namespace | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | AWS tags to be applied to resources | `map(string)` | `{}` | no |
| <a name="input_termination_protection"></a> [termination\_protection](#input\_termination\_protection) | Enables or disables container-aware termination of instances in the auto scaling group when scale-in happens. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_cloudwatch_log_group_arn"></a> [ecs\_cloudwatch\_log\_group\_arn](#output\_ecs\_cloudwatch\_log\_group\_arn) | The cloudwatch log group to be used by the cluster |
| <a name="output_ecs_cloudwatch_log_group_name"></a> [ecs\_cloudwatch\_log\_group\_name](#output\_ecs\_cloudwatch\_log\_group\_name) | The cloudwatch log group to be used by the cluster |
| <a name="output_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#output\_ecs\_cluster\_arn) | ARN of the ECS Cluster |
| <a name="output_ecs_cluster_id"></a> [ecs\_cluster\_id](#output\_ecs\_cluster\_id) | ID of the ECS Cluster |
| <a name="output_ecs_cluster_kms_arn"></a> [ecs\_cluster\_kms\_arn](#output\_ecs\_cluster\_kms\_arn) | The AWS Key Management Service key ID to encrypt the data between the local client and the container |
| <a name="output_ecs_cluster_name"></a> [ecs\_cluster\_name](#output\_ecs\_cluster\_name) | The name of the ECS cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
