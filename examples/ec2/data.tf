data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {} 

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

data "aws_subnets" "private" {
  filter {
    name = "tag:Name"
    values = ["*app*"]
  }
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
