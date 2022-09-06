variable "name" {
  description = "Name of the product/project/application"
  type        = string
  default     = null
}

##############################
# ECS
##############################
variable "link_ecs_to_asg_capacity_provider" {
  description = "Specify whether to link ECS to autoscaling group capacity provider"
  type        = bool
  default     = false
}

##############################
# ECS - service
##############################
variable "service_map" {
  description = "A map of services to deploy"
  type        = map(any)
  default     = {}
}

variable "service_task_execution_role_arn" {
  description = "IAM role for ECS execution"
  type        = string
}

variable "service_task_role_arn" {
  description = "IAM role for ECS task"
  type        = string
}

variable "service_subnets" {
  description = "Private subnets for ECS"
  type        = list(string)
  default     = []
}

variable "service_security_groups" {
  description = "Security group IDs to attach to your ECS Service"
  type        = list(string)
  default     = []
}

################################################################################
# Autoscaling group
################################################################################
variable "asg_create" {
  description = "Specify whether to create ASG resource"
  type        = bool
  default     = false
}

variable "asg_name" {
  description = "Name of ASG resource"
  type        = string
  default     = ""
}

variable "asg_instance_name" {
  description = "Name that is propogated to launched EC2 instances via a tag - if not provided, defaults to `var.name`"
  type        = string
  default     = ""
}

variable "asg_min_size" {
  description = "The minimum size of the autoscaling group"
  type        = number
  default     = null
}

variable "asg_max_size" {
  description = "The maximum size of the autoscaling group"
  type        = number
  default     = null
}

variable "asg_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the autoscaling group"
  type        = number
  default     = null
}

variable "asg_ignore_desired_capacity_changes" {
  description = "Determines whether the `desired_capacity` value is ignored after initial apply. See README note for more details"
  type        = bool
  default     = true
}

variable "asg_wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  type        = string
  default     = null
}

variable "asg_protect_from_scale_in" {
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events."
  type        = bool
  default     = false
}

variable "asg_health_check_type" {
  description = "`EC2` or `ELB`. Controls how health checking is done"
  type        = string
  default     = "ELB"
}

################################################################################
# Autoscaling group - launch template
################################################################################
variable "asg_launch_template_description" {
  description = "Description of the launch template"
  type        = string
  default     = null
}

variable "asg_image_id" {
  description = "The AMI from which to launch the instance"
  type        = string
  default     = ""
}

variable "asg_instance_type" {
  description = "The type of the instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "asg_ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = true
}

variable "asg_enable_monitoring" {
  description = "Enables/disables detailed monitoring"
  type        = bool
  default     = true
}

variable "asg_enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are `GroupDesiredCapacity`, `GroupInServiceCapacity`, `GroupPendingCapacity`, `GroupMinSize`, `GroupMaxSize`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupStandbyCapacity`, `GroupTerminatingCapacity`, `GroupTerminatingInstances`, `GroupTotalCapacity`, `GroupTotalInstances`"
  type        = list(string)
  default     = ["GroupDesiredCapacity", "GroupInServiceCapacity", "GroupPendingCapacity", "GroupMinSize", "GroupMaxSize", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupStandbyCapacity", "GroupTerminatingCapacity", "GroupTerminatingInstances", "GroupTotalCapacity", "GroupTotalInstances"]
}

variable "asg_user_data_base64" {
  description = "The Base64-encoded user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "asg_volume_size" {
  description = "Specify the volume size for the root ebs"
  type        = string
}

variable "asg_iam_instance_profile_arn" {
  description = "The IAM Instance Profile ARN to launch the instance with"
  type        = string
  default     = null
}

################################################################################
# Autoscaling group - network
################################################################################
variable "asg_subnets" {
  description = "A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with `availability_zones`"
  type        = list(string)
  default     = null
}

variable "asg_network_interface_security_groups" {
  description = "A list of security group IDs to associate"
  type        = list(string)
  default     = null
}

variable "asg_placement" {
  description = "The placement of the instance"
  type        = map(string)
  default     = null
}

################################################################################
# Autoscaling group - policy
################################################################################
variable "service_min_capacity" {
  description = "Minimum capacity of ECS autoscaling target, cannot be more than max_capacity"
  type        = number
  default     = 1
}

variable "service_max_capacity" {
  description = "Maximum capacity of ECS autoscaling target, cannot be less than min_capacity"
  type        = number
  default     = 4
}

variable "service_target_cpu_value" {
  description = "Autoscale when CPU Usage value over the specified value. Must be specified if `enable_cpu_based_autoscaling` is `true`."
  type        = number
  default     = 70
}

################################################################################
# Tags
################################################################################
variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}