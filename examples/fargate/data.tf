data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = ["*Main*"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["*app*"]
  }
}

data "aws_iam_policy_document" "execution_custom_policy" {
  statement {
    actions   = ["logs:CreateLogGroup"]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/ecs/ecs-${var.name}/*"]
  }
}

data "aws_iam_policy_document" "task_custom_policy" {
  statement {
    sid = "CustomTaskPolicy"

    actions = [
      "s3:Get*",
      "s3:List*",
    ]

    resources = [
      "*"
    ]
  }
}
