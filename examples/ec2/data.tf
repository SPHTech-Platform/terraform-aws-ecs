data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "vpc_id" {
  name = "/aft/provisioned/vpc/vpc_id"
}

data "aws_ssm_parameter" "private_subnets" {
  name = "/aft/provisioned/vpc/private_subnets"
}

data "aws_ssm_parameter" "public_subnets" {
  name = "/aft/provisioned/vpc/public_subnets"
}

data "aws_ssm_parameter" "bottlerocket_ami" {
  name = "/aws/service/bottlerocket/aws-ecs-1/x86_64/latest/image_id"
}

data "aws_iam_policy_document" "execution_custom_policy" {
  statement {
    actions   = ["logs:CreateLogGroup"]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/ecs/ecs-${var.name}/*"]
  }
}

data "aws_iam_policy_document" "task_custom_policy" {
  statement {
    sid = "VaultAuthMethod"

    actions = [
      "ec2:DescribeInstances",
      "iam:GetInstanceProfile",
      "iam:GetUser",
      "iam:GetRole"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:instance-profile/*",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/*"
    ]
  }
}





# locals {
#   ssm_aft_path   = "/aft/provisioned/vpc"
#   ssm_aft_params = toset(data.aws_ssm_parameters_by_path.vpc.names)

#   vpc_id           = nonsensitive(data.aws_ssm_parameter.vpc["${local.ssm_aft_path}/vpc_id"].value)
#   private_subnets  = split(",", nonsensitive(data.aws_ssm_parameter.vpc["${local.ssm_aft_path}/private_subnets"].value))
#   public_subnets  = split(",", nonsensitive(data.aws_ssm_parameter.vpc["${local.ssm_aft_path}/public_subnets"].value))
#   database_subnets = split(",", nonsensitive(data.aws_ssm_parameter.vpc["${local.ssm_aft_path}/database_subnets"].value))
# }

# data "aws_ssm_parameters_by_path" "vpc" {
#   path      = local.ssm_aft_path
#   recursive = true
# }

# data "aws_ssm_parameter" "vpc" {
#   for_each = local.ssm_aft_params
#   name     = each.key
# }


# data "aws_vpc" "aft" {
#   id = local.vpc_id
# }

# data "aws_subnet" "private" {
#   for_each = toset(local.private_subnets)
#   id       = each.value
# }

# data "aws_subnet" "public" {
#   for_each = toset(local.public_subnets)
#   id       = each.value
# }



