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
| <a name="module_asg"></a> [asg](#module\_asg) | terraform-aws-modules/autoscaling/aws | ~> 5.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Specify whether to create ASG resource | `bool` | `false` | no |
| <a name="input_create_launch_template"></a> [create\_launch\_template](#input\_create\_launch\_template) | Create a launch template or not | `bool` | `true` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the autoscaling group | `number` | `null` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `true` | no |
| <a name="input_enable_monitoring"></a> [enable\_monitoring](#input\_enable\_monitoring) | Enables/disables detailed monitoring | `bool` | `true` | no |
| <a name="input_enabled_metrics"></a> [enabled\_metrics](#input\_enabled\_metrics) | A list of metrics to collect. The allowed values are `GroupDesiredCapacity`, `GroupInServiceCapacity`, `GroupPendingCapacity`, `GroupMinSize`, `GroupMaxSize`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupStandbyCapacity`, `GroupTerminatingCapacity`, `GroupTerminatingInstances`, `GroupTotalCapacity`, `GroupTotalInstances` | `list(string)` | <pre>[<br>  "GroupDesiredCapacity",<br>  "GroupInServiceCapacity",<br>  "GroupPendingCapacity",<br>  "GroupMinSize",<br>  "GroupMaxSize",<br>  "GroupInServiceInstances",<br>  "GroupPendingInstances",<br>  "GroupStandbyInstances",<br>  "GroupStandbyCapacity",<br>  "GroupTerminatingCapacity",<br>  "GroupTerminatingInstances",<br>  "GroupTotalCapacity",<br>  "GroupTotalInstances"<br>]</pre> | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | `EC2` or `ELB`. Controls how health checking is done | `string` | `"ELB"` | no |
| <a name="input_iam_instance_profile_arn"></a> [iam\_instance\_profile\_arn](#input\_iam\_instance\_profile\_arn) | The IAM Instance Profile ARN to launch the instance with | `string` | `null` | no |
| <a name="input_ignore_desired_capacity_changes"></a> [ignore\_desired\_capacity\_changes](#input\_ignore\_desired\_capacity\_changes) | Determines whether the `desired_capacity` value is ignored after initial apply. See README note for more details | `bool` | `true` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | The AMI from which to launch the instance | `string` | `""` | no |
| <a name="input_instance_market_options"></a> [instance\_market\_options](#input\_instance\_market\_options) | The market (purchasing) option for the instance | `any` | `null` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name that is propogated to launched EC2 instances via a tag - if not provided, defaults to `var.name` | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance to launch | `string` | `null` | no |
| <a name="input_launch_template"></a> [launch\_template](#input\_launch\_template) | Name of an existing launch template to be used (created outside of this module) | `string` | `null` | no |
| <a name="input_launch_template_description"></a> [launch\_template\_description](#input\_launch\_template\_description) | Description of the launch template | `string` | `null` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | Launch type | `string` | `"EC2"` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of the autoscaling group | `number` | `null` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the autoscaling group | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the product/project/application | `string` | `""` | no |
| <a name="input_network_interface_security_groups"></a> [network\_interface\_security\_groups](#input\_network\_interface\_security\_groups) | A list of security group IDs to associate | `list(string)` | `null` | no |
| <a name="input_placement"></a> [placement](#input\_placement) | The placement of the instance | `map(string)` | `null` | no |
| <a name="input_protect_from_scale_in"></a> [protect\_from\_scale\_in](#input\_protect\_from\_scale\_in) | Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events. | `bool` | `false` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with `availability_zones` | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to resources | `map(string)` | `{}` | no |
| <a name="input_user_data_base64"></a> [user\_data\_base64](#input\_user\_data\_base64) | The Base64-encoded user data to provide when launching the instance | `string` | `null` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Specify the volume size for the root ebs | `string` | n/a | yes |
| <a name="input_wait_for_capacity_timeout"></a> [wait\_for\_capacity\_timeout](#input\_wait\_for\_capacity\_timeout) | A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_arn"></a> [autoscaling\_group\_arn](#output\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_autoscaling_group_id"></a> [autoscaling\_group\_id](#output\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | The autoscaling group name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_asg"></a> [asg](#module\_asg) | terraform-aws-modules/autoscaling/aws | ~> 5.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Specify whether to create ASG resource | `bool` | `false` | no |
| <a name="input_create_launch_template"></a> [create\_launch\_template](#input\_create\_launch\_template) | Create a launch template or not | `bool` | `true` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the autoscaling group | `number` | `null` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `true` | no |
| <a name="input_enable_monitoring"></a> [enable\_monitoring](#input\_enable\_monitoring) | Enables/disables detailed monitoring | `bool` | `true` | no |
| <a name="input_enabled_metrics"></a> [enabled\_metrics](#input\_enabled\_metrics) | A list of metrics to collect. The allowed values are `GroupDesiredCapacity`, `GroupInServiceCapacity`, `GroupPendingCapacity`, `GroupMinSize`, `GroupMaxSize`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupStandbyCapacity`, `GroupTerminatingCapacity`, `GroupTerminatingInstances`, `GroupTotalCapacity`, `GroupTotalInstances` | `list(string)` | <pre>[<br>  "GroupDesiredCapacity",<br>  "GroupInServiceCapacity",<br>  "GroupPendingCapacity",<br>  "GroupMinSize",<br>  "GroupMaxSize",<br>  "GroupInServiceInstances",<br>  "GroupPendingInstances",<br>  "GroupStandbyInstances",<br>  "GroupStandbyCapacity",<br>  "GroupTerminatingCapacity",<br>  "GroupTerminatingInstances",<br>  "GroupTotalCapacity",<br>  "GroupTotalInstances"<br>]</pre> | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | `EC2` or `ELB`. Controls how health checking is done | `string` | `"ELB"` | no |
| <a name="input_iam_instance_profile_arn"></a> [iam\_instance\_profile\_arn](#input\_iam\_instance\_profile\_arn) | The IAM Instance Profile ARN to launch the instance with | `string` | `null` | no |
| <a name="input_ignore_desired_capacity_changes"></a> [ignore\_desired\_capacity\_changes](#input\_ignore\_desired\_capacity\_changes) | Determines whether the `desired_capacity` value is ignored after initial apply. See README note for more details | `bool` | `true` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | The AMI from which to launch the instance | `string` | `""` | no |
| <a name="input_instance_market_options"></a> [instance\_market\_options](#input\_instance\_market\_options) | The market (purchasing) option for the instance | `any` | `null` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name that is propogated to launched EC2 instances via a tag - if not provided, defaults to `var.name` | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance to launch | `string` | `null` | no |
| <a name="input_launch_template"></a> [launch\_template](#input\_launch\_template) | Name of an existing launch template to be used (created outside of this module) | `string` | `null` | no |
| <a name="input_launch_template_description"></a> [launch\_template\_description](#input\_launch\_template\_description) | Description of the launch template | `string` | `null` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | Launch type | `string` | `"EC2"` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of the autoscaling group | `number` | `null` | no |
| <a name="input_metadata_options"></a> [metadata\_options](#input\_metadata\_options) | Customize the metadata options (IMDS) for the instance | <pre>object({<br>    http_endpoint               = string<br>    http_tokens                 = string<br>    http_put_response_hop_limit = number<br>    instance_metadata_tags      = string<br>  })</pre> | <pre>{<br>  "http_endpoint": "enabled",<br>  "http_put_response_hop_limit": 1,<br>  "http_tokens": "required",<br>  "instance_metadata_tags": "disabled"<br>}</pre> | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the autoscaling group | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the product/project/application | `string` | `""` | no |
| <a name="input_network_interface_security_groups"></a> [network\_interface\_security\_groups](#input\_network\_interface\_security\_groups) | A list of security group IDs to associate | `list(string)` | `null` | no |
| <a name="input_placement"></a> [placement](#input\_placement) | The placement of the instance | `map(string)` | `null` | no |
| <a name="input_protect_from_scale_in"></a> [protect\_from\_scale\_in](#input\_protect\_from\_scale\_in) | Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events. | `bool` | `false` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with `availability_zones` | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to resources | `map(string)` | `{}` | no |
| <a name="input_user_data_base64"></a> [user\_data\_base64](#input\_user\_data\_base64) | The Base64-encoded user data to provide when launching the instance | `string` | `null` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Specify the volume size for the root ebs | `string` | n/a | yes |
| <a name="input_wait_for_capacity_timeout"></a> [wait\_for\_capacity\_timeout](#input\_wait\_for\_capacity\_timeout) | A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_arn"></a> [autoscaling\_group\_arn](#output\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group |
| <a name="output_autoscaling_group_id"></a> [autoscaling\_group\_id](#output\_autoscaling\_group\_id) | The autoscaling group id |
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | The autoscaling group name |
<!-- END_TF_DOCS -->