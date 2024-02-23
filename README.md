<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_autoscaling_group"></a> [autoscaling\_group](#module\_autoscaling\_group) | ./modules/autoscaling-group | n/a |
| <a name="module_cluster"></a> [cluster](#module\_cluster) | ./modules/cluster | n/a |
| <a name="module_service"></a> [service](#module\_service) | ./modules/service | n/a |
| <a name="module_service_cpu_autoscaling_policy"></a> [service\_cpu\_autoscaling\_policy](#module\_service\_cpu\_autoscaling\_policy) | ./modules/autoscaling-policy | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_create"></a> [asg\_create](#input\_asg\_create) | Specify whether to create ASG resource | `bool` | `false` | no |
| <a name="input_asg_desired_capacity"></a> [asg\_desired\_capacity](#input\_asg\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the autoscaling group | `number` | `null` | no |
| <a name="input_asg_ebs_optimized"></a> [asg\_ebs\_optimized](#input\_asg\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `true` | no |
| <a name="input_asg_enable_monitoring"></a> [asg\_enable\_monitoring](#input\_asg\_enable\_monitoring) | Enables/disables detailed monitoring | `bool` | `true` | no |
| <a name="input_asg_enabled_metrics"></a> [asg\_enabled\_metrics](#input\_asg\_enabled\_metrics) | A list of metrics to collect. The allowed values are `GroupDesiredCapacity`, `GroupInServiceCapacity`, `GroupPendingCapacity`, `GroupMinSize`, `GroupMaxSize`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupStandbyCapacity`, `GroupTerminatingCapacity`, `GroupTerminatingInstances`, `GroupTotalCapacity`, `GroupTotalInstances` | `list(string)` | <pre>[<br>  "GroupDesiredCapacity",<br>  "GroupInServiceCapacity",<br>  "GroupPendingCapacity",<br>  "GroupMinSize",<br>  "GroupMaxSize",<br>  "GroupInServiceInstances",<br>  "GroupPendingInstances",<br>  "GroupStandbyInstances",<br>  "GroupStandbyCapacity",<br>  "GroupTerminatingCapacity",<br>  "GroupTerminatingInstances",<br>  "GroupTotalCapacity",<br>  "GroupTotalInstances"<br>]</pre> | no |
| <a name="input_asg_health_check_type"></a> [asg\_health\_check\_type](#input\_asg\_health\_check\_type) | `EC2` or `ELB`. Controls how health checking is done | `string` | `"ELB"` | no |
| <a name="input_asg_iam_instance_profile_arn"></a> [asg\_iam\_instance\_profile\_arn](#input\_asg\_iam\_instance\_profile\_arn) | The IAM Instance Profile ARN to launch the instance with | `string` | `null` | no |
| <a name="input_asg_ignore_desired_capacity_changes"></a> [asg\_ignore\_desired\_capacity\_changes](#input\_asg\_ignore\_desired\_capacity\_changes) | Determines whether the `desired_capacity` value is ignored after initial apply. See README note for more details | `bool` | `true` | no |
| <a name="input_asg_image_id"></a> [asg\_image\_id](#input\_asg\_image\_id) | The AMI from which to launch the instance | `string` | `""` | no |
| <a name="input_asg_instance_market_options"></a> [asg\_instance\_market\_options](#input\_asg\_instance\_market\_options) | The market (purchasing) option for the instance | `any` | `null` | no |
| <a name="input_asg_instance_name"></a> [asg\_instance\_name](#input\_asg\_instance\_name) | Name that is propogated to launched EC2 instances via a tag - if not provided, defaults to `var.name` | `string` | `""` | no |
| <a name="input_asg_instance_type"></a> [asg\_instance\_type](#input\_asg\_instance\_type) | The type of the instance to launch | `string` | `"t2.micro"` | no |
| <a name="input_asg_launch_template_description"></a> [asg\_launch\_template\_description](#input\_asg\_launch\_template\_description) | Description of the launch template | `string` | `null` | no |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | The maximum size of the autoscaling group | `number` | `null` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | The minimum size of the autoscaling group | `number` | `null` | no |
| <a name="input_asg_name"></a> [asg\_name](#input\_asg\_name) | Name of ASG resource | `string` | `""` | no |
| <a name="input_asg_network_interface_security_groups"></a> [asg\_network\_interface\_security\_groups](#input\_asg\_network\_interface\_security\_groups) | A list of security group IDs to associate | `list(string)` | `null` | no |
| <a name="input_asg_placement"></a> [asg\_placement](#input\_asg\_placement) | The placement of the instance | `map(string)` | `null` | no |
| <a name="input_asg_protect_from_scale_in"></a> [asg\_protect\_from\_scale\_in](#input\_asg\_protect\_from\_scale\_in) | Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events. | `bool` | `false` | no |
| <a name="input_asg_subnets"></a> [asg\_subnets](#input\_asg\_subnets) | A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with `availability_zones` | `list(string)` | `null` | no |
| <a name="input_asg_user_data_base64"></a> [asg\_user\_data\_base64](#input\_asg\_user\_data\_base64) | The Base64-encoded user data to provide when launching the instance | `string` | `null` | no |
| <a name="input_asg_volume_size"></a> [asg\_volume\_size](#input\_asg\_volume\_size) | Specify the volume size for the root ebs | `string` | `30` | no |
| <a name="input_asg_wait_for_capacity_timeout"></a> [asg\_wait\_for\_capacity\_timeout](#input\_asg\_wait\_for\_capacity\_timeout) | A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior. | `string` | `null` | no |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Enable a public IP address for the container | `bool` | `false` | no |
| <a name="input_capacity_providers"></a> [capacity\_providers](#input\_capacity\_providers) | List of short names of one or more capacity providers to associate with the cluster. Valid values also include FARGATE and FARGATE\_SPOT. | `list(string)` | `[]` | no |
| <a name="input_create_launch_template"></a> [create\_launch\_template](#input\_create\_launch\_template) | Create a launch template | `bool` | `true` | no |
| <a name="input_default_capacity_provider_strategy"></a> [default\_capacity\_provider\_strategy](#input\_default\_capacity\_provider\_strategy) | The capacity provider strategy to use by default for the cluster. Can be one or more. | `list(map(any))` | `[]` | no |
| <a name="input_enable_execute_command"></a> [enable\_execute\_command](#input\_enable\_execute\_command) | Specifies whether to enable Amazon ECS Exec for the tasks within the service | `bool` | `false` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | The launch type on which to run your task.(EC2\|FARGATE) | `string` | `"EC2"` | no |
| <a name="input_link_ecs_to_asg_capacity_provider"></a> [link\_ecs\_to\_asg\_capacity\_provider](#input\_link\_ecs\_to\_asg\_capacity\_provider) | Specify whether to link ECS to autoscaling group capacity provider | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the product/project/application | `string` | `""` | no |
| <a name="input_platform_version"></a> [platform\_version](#input\_platform\_version) | Platform version (applicable for FARGATE launch type) | `string` | `"LATEST"` | no |
| <a name="input_service_connect_defaults"></a> [service\_connect\_defaults](#input\_service\_connect\_defaults) | Configures a Service Connect Namespace | `map(string)` | `{}` | no |
| <a name="input_service_deployment_maximum_percent"></a> [service\_deployment\_maximum\_percent](#input\_service\_deployment\_maximum\_percent) | Upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Not valid when using the DAEMON scheduling strategy. | `number` | `200` | no |
| <a name="input_service_deployment_minimum_healthy_percent"></a> [service\_deployment\_minimum\_healthy\_percent](#input\_service\_deployment\_minimum\_healthy\_percent) | Lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. | `number` | `100` | no |
| <a name="input_service_map"></a> [service\_map](#input\_service\_map) | A map of services to deploy | `map(any)` | `{}` | no |
| <a name="input_service_max_capacity"></a> [service\_max\_capacity](#input\_service\_max\_capacity) | Maximum capacity of ECS autoscaling target, cannot be less than min\_capacity | `number` | `4` | no |
| <a name="input_service_min_capacity"></a> [service\_min\_capacity](#input\_service\_min\_capacity) | Minimum capacity of ECS autoscaling target, cannot be more than max\_capacity | `number` | `1` | no |
| <a name="input_service_scale_in_cooldown"></a> [service\_scale\_in\_cooldown](#input\_service\_scale\_in\_cooldown) | Time between scale in action | `number` | `300` | no |
| <a name="input_service_scale_out_cooldown"></a> [service\_scale\_out\_cooldown](#input\_service\_scale\_out\_cooldown) | Time between scale out action | `number` | `300` | no |
| <a name="input_service_security_groups"></a> [service\_security\_groups](#input\_service\_security\_groups) | Security group IDs to attach to your ECS Service | `list(string)` | `[]` | no |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | Private subnets for ECS | `list(string)` | `[]` | no |
| <a name="input_service_target_cpu_value"></a> [service\_target\_cpu\_value](#input\_service\_target\_cpu\_value) | Autoscale when CPU Usage value over the specified value. Must be specified if `enable_cpu_based_autoscaling` is `true`. | `number` | `70` | no |
| <a name="input_service_task_execution_role_arn"></a> [service\_task\_execution\_role\_arn](#input\_service\_task\_execution\_role\_arn) | Default IAM role for ECS execution | `string` | `""` | no |
| <a name="input_service_task_role_arn"></a> [service\_task\_role\_arn](#input\_service\_task\_role\_arn) | Default IAM role for ECS task | `string` | `""` | no |
| <a name="input_task_placement_constraints"></a> [task\_placement\_constraints](#input\_task\_placement\_constraints) | The rules that are taken into consideration during task placement. Maximum number of placement\_constraints is 10 | <pre>list(object({<br>    type       = string<br>    expression = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_ecs_task_definition"></a> [aws\_ecs\_task\_definition](#output\_aws\_ecs\_task\_definition) | ARN of the ECS service |
| <a name="output_ecs_cloudwatch_log_group_arn"></a> [ecs\_cloudwatch\_log\_group\_arn](#output\_ecs\_cloudwatch\_log\_group\_arn) | The cloudwatch log group to be used by the cluster |
| <a name="output_ecs_cloudwatch_log_group_name"></a> [ecs\_cloudwatch\_log\_group\_name](#output\_ecs\_cloudwatch\_log\_group\_name) | The cloudwatch log group to be used by the cluster |
| <a name="output_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#output\_ecs\_cluster\_arn) | ARN of the ECS Cluster |
| <a name="output_ecs_cluster_id"></a> [ecs\_cluster\_id](#output\_ecs\_cluster\_id) | ID of the ECS Cluster |
| <a name="output_ecs_cluster_kms_arn"></a> [ecs\_cluster\_kms\_arn](#output\_ecs\_cluster\_kms\_arn) | The AWS Key Management Service key ID to encrypt the data between the local client and the container |
| <a name="output_ecs_cluster_name"></a> [ecs\_cluster\_name](#output\_ecs\_cluster\_name) | The name of the ECS cluster |
| <a name="output_ecs_service_arn"></a> [ecs\_service\_arn](#output\_ecs\_service\_arn) | ARN of the ECS service |
| <a name="output_ecs_service_name"></a> [ecs\_service\_name](#output\_ecs\_service\_name) | The name of the ECS service |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
