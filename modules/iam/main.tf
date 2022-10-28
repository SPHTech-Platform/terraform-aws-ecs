module "iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4.13.0"

  trusted_role_arns       = var.trusted_role_arns
  trusted_role_services   = var.trusted_role_services
  custom_role_policy_arns = var.custom_role_policy_arns

  create_role             = true
  create_instance_profile = var.create_instance_profile
  role_requires_mfa       = false

  role_name = var.role_name

  tags = merge(var.tags, { "Name" = var.role_name })
}

module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 4.13.0"

  create_policy = length(var.policy) > 0 ? true : false
  policy        = var.policy
  name          = var.policy_name
  description   = var.policy_description

  tags = merge(var.tags, { "Name" = var.policy_name })
}

resource "aws_iam_role_policy_attachment" "attach" {
  count = length(var.policy) > 0 ? 1 : 0

  role       = module.iam_assumable_role.iam_role_name
  policy_arn = module.iam_policy.arn
}
