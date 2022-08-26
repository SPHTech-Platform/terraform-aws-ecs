locals {
  ssm_string_values = {
    vpc_id                = "null"
    igw_id                = "null"
    database_subnet_group = "null"
  }

  ssm_list_values = {
    azs              = ["null"]
    database_subnets = ["null"]
    nat_ids          = ["null"]
    nat_public_ips   = ["null"]
    natgw_ids        = ["null"]
    private_subnets  = ["null"]
    public_subnets   = ["null"]
  }

  standard_tags = merge(
    { for k, v in var.standard_tags : "sph:${replace(k, "_", "-")}" => v if v != null && v != "" },
    { map-migrated = var.map_migrated },
  )
}

resource "aws_ssm_parameter" "string" {
  #checkov:skip=CKV2_AWS_34
  for_each = local.ssm_string_values

  name           = join("/", [var.ssm_path, each.key])
  type           = "String"
  insecure_value = each.value

  tags = local.standard_tags
}

resource "aws_ssm_parameter" "string_list" {
  #checkov:skip=CKV2_AWS_34
  for_each = { for k, v in local.ssm_list_values : k => v if v != null }

  name           = join("/", [var.ssm_path, each.key])
  type           = "StringList"
  insecure_value = join(",", each.value)

  tags = local.standard_tags
}
