data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "cloudwatch_logs_allow_kms" {
  #checkov:skip=CKV_AWS_356: Accept risk of using wildcard resource

  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        length(var.key_admin_arn) == 0 ? "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" : var.key_admin_arn
      ]
    }

    actions = [
      "kms:*",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "Allow logs KMS access"
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        format(
          "logs.%s.amazonaws.com",
          data.aws_region.current.name
        )
      ]
    }

    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    #checkov:skip=CKV_AWS_109:Not passing cw arn to avoid cyclic dependency
    #checkov:skip=CKV_AWS_111:Not passing cw arn to avoid cyclic dependency
    resources = ["*"]
  }
}
