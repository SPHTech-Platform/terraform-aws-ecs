resource "aws_iam_role" "iam_role" {
  name = var.role_name

  force_detach_policies = true
  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy.json
  managed_policy_arns   = var.custom_role_policy_arns

  tags = merge(var.tags, { "Name" = var.role_name })
}

resource "aws_iam_instance_profile" "iam_instance_role" {
  count = var.create_instance_profile ? 1 : 0

  name = var.role_name
  path = "/"
  role = aws_iam_role.iam_assumable_role.name

  tags = var.tags
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
