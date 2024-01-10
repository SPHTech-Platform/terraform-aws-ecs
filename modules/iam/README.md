<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_assumable_role"></a> [iam\_assumable\_role](#module\_iam\_assumable\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role | ~> 4.13.0 |
| <a name="module_iam_policy"></a> [iam\_policy](#module\_iam\_policy) | terraform-aws-modules/iam/aws//modules/iam-policy | ~> 4.13.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role_policy_attachment.attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_instance_profile"></a> [create\_instance\_profile](#input\_create\_instance\_profile) | Whether to create the instance profile | `bool` | `true` | no |
| <a name="input_custom_role_policy_arns"></a> [custom\_role\_policy\_arns](#input\_custom\_role\_policy\_arns) | List of ARNs of IAM policies to attach to IAM role | `list(string)` | `[]` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | The path of the policy in IAM (tpl file) | `string` | `""` | no |
| <a name="input_policy_description"></a> [policy\_description](#input\_policy\_description) | The description of the policy | `string` | `"IAM Policy"` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | The name of the policy | `string` | `""` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | IAM role name | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to IAM role resources | `map(string)` | `{}` | no |
| <a name="input_trusted_role_arns"></a> [trusted\_role\_arns](#input\_trusted\_role\_arns) | ARNs of AWS entities who can assume these roles | `list(string)` | `[]` | no |
| <a name="input_trusted_role_services"></a> [trusted\_role\_services](#input\_trusted\_role\_services) | AWS Services that can assume these roles | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_instance_profile_arn"></a> [iam\_instance\_profile\_arn](#output\_iam\_instance\_profile\_arn) | ARN of IAM instance profile |
| <a name="output_iam_instance_profile_name"></a> [iam\_instance\_profile\_name](#output\_iam\_instance\_profile\_name) | Name of IAM instance profile |
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | The ARN assigned by AWS to this policy |
| <a name="output_iam_policy_id"></a> [iam\_policy\_id](#output\_iam\_policy\_id) | The policy's ID |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of IAM role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
