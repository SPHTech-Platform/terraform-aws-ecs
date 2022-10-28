output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = try(module.iam_assumable_role.iam_role_arn, "")
}

output "iam_role_name" {
  description = "Name of IAM role"
  value       = try(module.iam_assumable_role.iam_role_name, "")
}

output "iam_instance_profile_arn" {
  description = "ARN of IAM instance profile"
  value       = try(module.iam_assumable_role.iam_instance_profile_arn, "")
}

output "iam_instance_profile_name" {
  description = "Name of IAM instance profile"
  value       = try(module.iam_assumable_role.iam_instance_profile_name, "")
}

output "iam_policy_id" {
  description = "The policy's ID"
  value       = try(module.iam_policy.id, "")
}

output "iam_policy_arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = try(module.iam_policy.arn, "")
}
