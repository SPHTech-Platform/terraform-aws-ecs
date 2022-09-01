variable "name" {
  description = "Name of the product/project/application"
  type        = string
  default     = null
}

##############################
# ECS
##############################
variable "link_ecs_to_asg_capacity_provider" {
  description = "Specify whether link ECS to autoscaling group capacity provider"
  type        = bool
  default     = false
}

##############################
# ECS - service
##############################
variable "task_cpu" {
  description = "Number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required."
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Amount (in MiB) of memory used by the task. If the requires_compatibilities is FARGATE this field is required."
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Number of instances of the task definition to place and keep running. "
  default     = 1
  type        = number
}

variable "service_map" {
  description = "A map of services to deploy"
  type = map
  default = {}
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

variable "asg_subnets" {
  description = "A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with `availability_zones`"
  type        = list(string)
  default     = null
}

################################################################################
# Autoscaling group - policy
################################################################################
variable "min_capacity" {
  description = "Minimum capacity of ECS autoscaling target, cannot be more than max_capacity"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum capacity of ECS autoscaling target, cannot be less than min_capacity"
  type        = number
  default     = 4
}

variable "target_cpu_value" {
  description = "Autoscale when CPU Usage value over the specified value. Must be specified if `enable_cpu_based_autoscaling` is `true`."
  type        = number
  default     = 70
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
  default     = ""
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

variable "asg_iam_instance_profile_arn" {
  description = "The IAM Instance Profile ARN to launch the instance with"
  type        = string
  default     = null
}

################################################################################
# Autoscaling group - block
################################################################################
variable "asg_volume_size" {
  description = "Specify the volume size for the root ebs"
  type        = string
}

################################################################################
# Autoscaling group - network
################################################################################
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
# Tags
################################################################################
variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}
