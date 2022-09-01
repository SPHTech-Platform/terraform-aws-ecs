data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "vpc_id" {
  name = "/aft/provisioned/vpc/vpc_id"
}

data "aws_ssm_parameter" "private_subnets" {
  name = "/aft/provisioned/vpc/private_subnets"
}

data "aws_ssm_parameter" "bottlerocket_ami" {
  name = "/aws/service/bottlerocket/aws-ecs-1/x86_64/latest/image_id"
}
