variable "ssm_path" {
  description = "Base Path for SSM VPC Parameters"
  type        = string
  default     = "/aft/provisioned/vpc"
}

################################################################################
# SSM - tags
################################################################################
variable "standard_tags" {
  description = "Standard tags. If value is not applicable leave as empty or null."
  type = object({
    env         = string
    app_tier    = string
    appteam     = string
    biz_dept    = string
    cost_centre = string
    product     = string
  })

  validation {
    condition = alltrue([
      for _tagkey, tagvalue in var.standard_tags : can(regex("^[A-Za-z0-9? _.:/=+@-]+$", tagvalue))
    ])
    error_message = "Invalid tag value. Tag values for AWS accounts can only contain alphanumeric characters, spaces, and any of the following characters within the double quotes \"_.:/=+@-\"."
  }
}

variable "map_migrated" {
  description = "Map-migrated discount code"
  type        = string
  default     = "d-server-00fyc0pr7gc8hv"
}