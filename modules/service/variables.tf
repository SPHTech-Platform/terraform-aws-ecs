variable "create" {
  description = "Determines whether resources will be created"
  type        = bool
  default     = true
}

variable "ignore_taskdef" {
  description = "Whether changes to task_def should update the service"
  type        = bool
  default     = false
}

variable "name" {
  description = "The Service name"
  type        = string
}

################################################################################
# ECS Service
################################################################################
variable "cluster_id" {
  description = "Cluster ID"
  type        = string
}

variable "launch_type" {
  description = "Launch type"
  type        = string
  default     = "EC2"
}

variable "platform_version" {
  description = "Platform version (applicable for FARGATE launch type)"
  type        = string
  default     = "LATEST"
}

variable "desired_count" {
  description = "Number of instances of the task definition to place and keep running."
  type        = number
  default     = 0
}

variable "enable_ecs_managed_tags" {
  description = "Specifies whether to enable Amazon ECS managed tags for the tasks within the service"
  type        = bool
  default     = true
}

variable "enable_execute_command" {
  description = "Specifies whether to enable Amazon ECS Exec for the tasks within the service"
  type        = bool
  default     = false
}

variable "propagate_tags" {
  description = "Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION"
  type        = string
  default     = "TASK_DEFINITION"
}

variable "deployment_controller_type" {
  description = "Type of deployment controller. Valid values are `CODE_DEPLOY` and `ECS`"
  type        = string
  default     = "ECS"
}

variable "service_placement_constraints" {
  description = "The rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10."
  type = list(object({
    type       = string
    expression = string
  }))
  default = []
}

variable "network_mode" {
  description = "Networking Mode Type"
  type        = string
  default     = "awsvpc"
}

variable "subnets" {
  description = "Private subnets for ECS"
  type        = list(string)
  default     = null
}

variable "security_groups" {
  description = "Security group IDs to attach to your ECS Service"
  type        = list(string)
  default     = null
}

variable "assign_public_ip" {
  description = "Flag for enabling/disabling public IP for ECS Containers"
  type        = bool
  default     = false
}

variable "ordered_placement_strategy" {
  description = "Service level strategy rules that are taken into consideration during task placement."
  type = list(object({
    type  = string
    field = string
  }))
  default = []
}

variable "ecs_load_balancers" {
  description = "Configuration block for load balancers."
  type        = list(any)
  default     = []
}

variable "service_registries" {
  description = "Service discovery registries for the service. The maximum number of service_registries blocks is 1"
  type        = list(any)
  default     = []
}

variable "deployment_maximum_percent" {
  description = "Upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Not valid when using the DAEMON scheduling strategy."
  type        = number
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "Lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment."
  type        = number
  default     = 100
}

################################################################################
# ECS Task Definition
################################################################################
variable "container_definitions" {
  description = "A list of container definitions in JSON format that describe the different containers that make up your task"
  type        = string
}

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

variable "execution_role_arn" {
  description = "ECS excution role arn"
  type        = string
  default     = ""
}

variable "task_role_arn" {
  description = "Task role arn"
  type        = string
  default     = ""
}

variable "task_placement_constraints" {
  description = "The rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10"
  type = list(object({
    type       = string
    expression = string
  }))
  default = []
}

################################################################################
# Volume Config
################################################################################
variable "efs_volumes" {
  description = "Task EFS volume definitions as list of configuration objects. You cannot define both Docker volumes and EFS volumes on the same task definition."
  type        = list(any)
  default     = []
}

variable "docker_volumes" {
  description = "Task docker volume definitions as list of configuration objects. You cannot define both Docker volumes and EFS volumes on the same task definition."
  type        = list(any)
  default     = []
}

################################################################################
# Tagging
################################################################################
variable "tags" {
  description = "Tags for ECS cluster"
  type        = map(string)
  default     = {}
}
