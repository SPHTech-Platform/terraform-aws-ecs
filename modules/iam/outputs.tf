output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = try(aws_iam_role.iam_role.arn, "")
}

output "iam_role_name" {
  description = "Name of IAM role"
  value       = try(aws_iam_role.iam_role.name, "")
}

output "iam_instance_profile_arn" {
  description = "ARN of IAM instance profile"
  value       = try(aws_iam_instance_profile.iam_instance_role[0].arn, "")
}

output "iam_instance_profile_name" {
  description = "Name of IAM instance profile"
  value       = try(aws_iam_instance_profile.iam_instance_role[0].name, "")
}

output "iam_policy_id" {
  description = "The policy's ID"
  value       = try(module.iam_policy.id, "")
}

output "iam_policy_arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = try(module.iam_policy.arn, "")
}
