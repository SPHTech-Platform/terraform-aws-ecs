################################################################################
# Create Role
################################################################################
variable "role_name" {
  description = "IAM role name"
  type        = string
  default     = null
}

variable "create_instance_profile" {
  description = "Whether to create the instance profile"
  type        = bool
  default     = true
}

variable "trusted_role_arns" {
  description = "ARNs of AWS entities who can assume these roles"
  type        = list(string)
  default     = []
}

variable "trusted_role_services" {
  description = "AWS Services that can assume these roles"
  type        = list(string)
  default     = []
}

variable "custom_role_policy_arns" {
  description = "List of ARNs of IAM policies to attach to IAM role"
  type        = list(string)
  default     = []
}

################################################################################
# IAM User
################################################################################
variable "create_user" {
  description = "Whether to create the IAM user"
  type        = bool
  default     = true
}

variable "user_name" {
  description = "Desired name for the IAM user"
  type        = string
  default     = null
}

################################################################################
# IAM Policy
################################################################################
# variable "create_policy" {
#   description = "Whether to create the IAM policy"
#   type        = bool
#   default     = true
# }

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = ""
}

variable "policy_description" {
  description = "The description of the policy"
  type        = string
  default     = "IAM Policy"
}

variable "policy" {
  description = "The path of the policy in IAM (tpl file)"
  type        = string
  default     = ""
}

################################################################################
# Tagging
################################################################################
variable "tags" {
  description = "A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
}
