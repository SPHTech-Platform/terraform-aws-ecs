variable "create_log_group" {
  description = "Whether to create log group"
  type        = bool
  default     = true
}

variable "log_group_name" {
  description = "Provide name for log group"
  type        = string
  default     = ""
}

variable "log_retention" {
  description = "Specify log retention in days"
  type        = number
  default     = 30
}

variable "log_encryption_enabled" {
  description = "Whether to enable log encryption"
  type        = bool
  default     = false
}

variable "create_ecs_asg_capacity_provider" {
  description = "Specify whether to create autoscaling based capacity provider"
  type        = bool
  default     = false
}

variable "create_capacity_provider" {
  description = "Specify whether to create autoscaling based capacity provider"
  type        = bool
  default     = false
}

variable "default_capacity_provider_strategy" {
  description = "The capacity provider strategy to use by default for the cluster. Can be one or more."
  type        = list(map(any))
  default     = []
}

variable "capacity_provider_name" {
  description = "Name for ECS capacity provider"
  type        = string
  default     = ""
}

variable "capacity_providers" {
  description = "List of short names of one or more capacity providers to associate with the cluster. Valid values also include FARGATE and FARGATE_SPOT."
  type        = list(string)
  default     = []
}

variable "key_admin_arn" {
  description = "Key administrator principal for the KMS key"
  type        = string
  default     = ""
}

variable "tags" {
  description = "AWS tags to be applied to resources"
  type        = map(string)
  default     = {}
}

variable "asg_arn" {
  description = "Autoscaling Group ARN"
  type        = string
  default     = ""
}

variable "termination_protection" {
  description = "Enables or disables container-aware termination of instances in the auto scaling group when scale-in happens."
  type        = bool
  default     = true
}

variable "managed_scaling" {
  description = "Specifies whether to enable managed scaling"
  type        = bool
  default     = true
}

variable "scaling_max_step_size" {
  description = "Sets managed scaling max step size"
  type        = number
  default     = 10
}

variable "scaling_min_step_size" {
  description = "Sets managed scaling min step size"
  type        = number
  default     = 1
}

variable "scaling_target_capacity" {
  description = "Sets managed scaling target capacity"
  type        = number
  default     = 80
}

variable "ecs_cluster_name" {
  description = "Name of the ecs cluster"
  type        = string
  default     = null
}

variable "ecs_container_insights" {
  description = "Whether to enable container insights for ECS cluster"
  type        = bool
  default     = true
}

variable "ecs_encrypt_logs" {
  description = "Enable encryption for cloudwatch logs"
  type        = bool
  default     = true
}
