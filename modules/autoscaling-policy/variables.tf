variable "name" {
  description = "Name of the ECS Policy created, will appear in Auto Scaling under Service in ECS"
  type        = string
}

################################################################################
# Autoscaling target
################################################################################
variable "ecs_cluster_name" {
  description = "ECS Cluster name to apply on (NOT ARN)"
  type        = string
}

variable "min_capacity" {
  description = "Minimum capacity of ECS autoscaling target, cannot be more than max_capacity"
  type        = number
}

variable "max_capacity" {
  description = "Maximum capacity of ECS autoscaling target, cannot be less than min_capacity"
  type        = number
}

variable "ecs_service_name" {
  description = "ECS Service name to apply on (NOT ARN)"
  type        = string
}

################################################################################
# App autoscaling policy
################################################################################
variable "enable_ecs_cpu_based_autoscaling" {
  description = "Enable Autoscaling based on ECS Service CPU Usage"
  type        = bool
  default     = false
}

variable "target_cpu_value" {
  description = "Autoscale when CPU Usage value over the specified value. Must be specified if `enable_cpu_based_autoscaling` is `true`."
  type        = number
  default     = null
}

variable "disable_scale_in" {
  description = "Disable scale-in action, defaults to false"
  type        = bool
  default     = false
}

variable "scale_in_cooldown" {
  description = "Time between scale in action"
  type        = number
  default     = 300
}

variable "scale_out_cooldown" {
  description = "Time between scale out action"
  type        = number
  default     = 300
}

variable "enable_ecs_memory_based_autoscaling" {
  description = "Enable Autoscaling based on ECS Service Memory Usage"
  type        = bool
  default     = false
}

variable "target_memory_value" {
  description = "Autoscale when Memory Usage value over the specified value. Must be specified if `enable_memory_based_autoscaling` is `true`."
  type        = number
  default     = null
}

################################################################################
# Autoscaling policy
################################################################################
variable "enable_asg_cpu_based_autoscaling" {
  description = "Enable Autoscaling based on ECS Cluster CPU Reservation"
  type        = bool
  default     = false
}

variable "autoscaling_group_name" {
  description = "Autoscaling Group to apply the policy"
  type        = string
  default     = null
}

variable "cpu_threshold" {
  description = "Keep the ECS Cluster CPU Reservation around this value. Value is in percentage (0..100). Must be specified if cpu based autoscaling is enabled."
  type        = number
  default     = null
}


variable "enable_asg_memory_based_autoscaling" {
  description = "Enable Autoscaling based on ECS Cluster Memory Reservation"
  type        = bool
  default     = false
}


variable "memory_threshold" {
  description = "Keep the ECS Cluster Memory Reservation around this value. Value is in percentage (0..100). Must be specified if memory based autoscaling is enabled."
  type        = number
  default     = null
}

variable "cpu_statistics" {
  description = "Statistics to use: [Maximum, SampleCount, Sum, Minimum, Average]. Note that resolution used in alarm generated is 1 minute."
  type        = string
  default     = "Average"
}

variable "memory_statistics" {
  description = "Statistics to use: [Maximum, SampleCount, Sum, Minimum, Average]. Note that resolution used in alarm generated is 1 minute."
  type        = string
  default     = "Average"
}

################################################################################
# Autoscaling scheduler
################################################################################

variable "autoscaling_scheduled_actions" {
  type = map(object({
    create           = bool
    desired_capacity = number
    min_size         = number
    max_size         = number
    recurrence       = string
    start_time       = string
    end_time         = string
    suspend_actions  = list(string)
  }))
}
