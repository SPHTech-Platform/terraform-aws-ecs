variable "name" {
  description = "Name of the product/project/application"
  type        = string
  default     = null
}

################################################################################
# Autoscaling group
################################################################################
variable "create" {
  description = "Specify whether to create ASG resource"
  type        = bool
  default     = false
}

variable "instance_name" {
  description = "Name that is propogated to launched EC2 instances via a tag - if not provided, defaults to `var.name`"
  type        = string
  default     = ""
}

variable "min_size" {
  description = "The minimum size of the autoscaling group"
  type        = number
  default     = null
}

variable "max_size" {
  description = "The maximum size of the autoscaling group"
  type        = number
  default     = null
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the autoscaling group"
  type        = number
  default     = null
}

variable "ignore_desired_capacity_changes" {
  description = "Determines whether the `desired_capacity` value is ignored after initial apply. See README note for more details"
  type        = bool
  default     = true
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  type        = string
  default     = null
}

variable "protect_from_scale_in" {
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events."
  type        = bool
  default     = false
}

variable "health_check_type" {
  description = "`EC2` or `ELB`. Controls how health checking is done"
  type        = string
  default     = "ELB"
}

variable "subnets" {
  description = "A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with `availability_zones`"
  type        = list(string)
  default     = null
}

################################################################################
# Autoscaling group - launch template
################################################################################
variable "launch_template_description" {
  description = "Description of the launch template"
  type        = string
  default     = null
}

variable "image_id" {
  description = "The AMI from which to launch the instance"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The type of the instance to launch"
  type        = string
  default     = ""
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = true
}

variable "enable_monitoring" {
  description = "Enables/disables detailed monitoring"
  type        = bool
  default     = true
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are `GroupDesiredCapacity`, `GroupInServiceCapacity`, `GroupPendingCapacity`, `GroupMinSize`, `GroupMaxSize`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupStandbyCapacity`, `GroupTerminatingCapacity`, `GroupTerminatingInstances`, `GroupTotalCapacity`, `GroupTotalInstances`"
  type        = list(string)
  default     = ["GroupDesiredCapacity", "GroupInServiceCapacity", "GroupPendingCapacity", "GroupMinSize", "GroupMaxSize", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupStandbyCapacity", "GroupTerminatingCapacity", "GroupTerminatingInstances", "GroupTotalCapacity", "GroupTotalInstances"]
}

variable "user_data_base64" {
  description = "The Base64-encoded user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "iam_instance_profile_arn" {
  description = "The IAM Instance Profile ARN to launch the instance with"
  type        = string
  default     = null
}

################################################################################
# Autoscaling group - block
################################################################################
variable "volume_size" {
  description = "Specify the volume size for the root ebs"
  type        = string
}

################################################################################
# Autoscaling group - network
################################################################################
variable "network_interface_security_groups" {
  description = "A list of security group IDs to associate"
  type        = list(string)
  default     = null
}

variable "placement" {
  description = "The placement of the instance"
  type        = map(string)
  default     = null
}

################################################################################
# Autoscaling group - tags
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
