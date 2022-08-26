data "aws_ssm_parameters_by_path" "vpc_id" {
  path = "/aft/provisioned/vpc/vpc_id"
}

data "aws_ssm_parameters_by_path" "private_subnets" {
  path = "/aft/provisioned/vpc/private_subnets"
}