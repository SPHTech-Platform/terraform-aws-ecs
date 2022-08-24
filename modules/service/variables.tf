# service variables
variable "name" {
  description = "The Service name"
  type        = string
}

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
  description = "Desired count"
  type        = number
  default     = 0
}

variable "enable_ecs_managed_tags" {
  description = "Specifies whether to enable Amazon ECS managed tags for the tasks within the service"
  type        = bool
  default     = true
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

variable "create_service_registry" {
  description = "Specify whether to create service registry"
  type        = bool
  default     = false
}

variable "registry_arn" {
  description = "ARN of the Service Registry.The currently supported service registry is Amazon Route 53 Auto Naming Service(aws_service_discovery_service) "
  type        = string
  default     = ""
}

variable "registry_port" {
  description = "Port value used if your Service Discovery service specified an SRV record"
  type        = string
  default     = ""
}

variable "registry_container_port" {
  description = "Port value, already specified in the task definition, to be used for your service discovery service"
  type        = string
  default     = ""
}

variable "registry_container_name" {
  description = "Container name value, already specified in the task definition, to be used for your service discovery service"
  type        = string
  default     = ""
}

## task definition variables
variable "container_definitions" {
  description = "A list of container definitions in JSON format that describe the different containers that make up your task"
  type        = string
  default     = ""
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

variable "network_mode" {
  description = "Networking Mode Type"
  type        = string
  default     = "awsvpc"
}

# # common variables
variable "tags" {
  description = "Tags for ECS cluster"
  type        = map(string)
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

variable "deployment_controller" {
  description = "Deployment controller"
  type        = string
  default     = "ECS"
}

variable "volume_name" {
  description = "Volume name to be used for mapping"
  type        = string
  default     = ""
}

variable "task_role_arn" {
  description = "Task role arn"
  type        = string
  default     = ""
}

variable "execution_role_arn" {
  description = "ECS excution role arn"
  type        = string
  default     = ""
}

variable "target_groups" {
  description = "Target group ARN for load balance config"
  type        = string
  default     = ""
}

variable "efs_id" {
  description = "EFS filesytem ID"
  type        = string
  default     = ""
}

variable "root_dir" {
  description = "Root directory for volume mapping"
  type        = string
  default     = ""
}

variable "efs_transit_encryption" {
  description = "EFS transit encryption status"
  type        = string
  default     = "DISABLED"
}

variable "driver" {
  description = "Docker volume driver to use"
  type        = string
  default     = ""
}

variable "volume_labels" {
  description = "Map of custom metadata to add to your Docker volume"
  type        = map(any)
  default     = null
}

variable "create_lb" {
  description = "whether need to create lb"
  type        = bool
  default     = true
}

variable "max_capacity" {
  description = "The max capacity of the scalable target"
  type        = number
  default     = 10
}

variable "min_capacity" {
  description = "The min capacity of the scalable target"
  type        = number
  default     = 0
}

variable "predefined_metric_type" {
  description = "Predefined metric for target_tracking_scaling for ECS service"
  type        = string
  default     = "ECSServiceAverageCPUUtilization"
}

variable "target_value" {
  description = "The target value for the metric"
  type        = number
  default     = 70
}

variable "scale_in_cooldown" {
  description = "The amount of time, in seconds, after a scale in activity completes before another scale in activity can start."
  type        = number
  default     = 300
}

variable "scale_out_cooldown" {
  description = "The amount of time, in seconds, after a scale out activity completes before another scale out activity can start"
  type        = number
  default     = 300
}

# Volume config
variable "efs_volumes" {
  # type = list(object({
  #   host_path = string
  #   name      = string
  #   efs_volume_configuration = list(object({
  #     file_system_id          = string
  #     root_directory          = string
  #     transit_encryption      = optional(string)
  #     transit_encryption_port = optional(string)
  #     authorization_config = optional(list(object({
  #       access_point_id = string
  #       iam             = string
  #     })))
  #   }))
  # }))
  description = "Task EFS volume definitions as list of configuration objects. You cannot define both Docker volumes and EFS volumes on the same task definition."
  type        = list(any)
  default     = []
}

variable "docker_volumes" {
  # type = list(object({
  #   host_path = string
  #   name      = string
  #   docker_volume_configuration = list(object({
  #     autoprovision = bool
  #     driver        = string
  #     driver_opts   = map(string)
  #     labels        = map(string)
  #     scope         = string
  #   }))
  # }))
  description = "Task docker volume definitions as list of configuration objects. You cannot define both Docker volumes and EFS volumes on the same task definition."
  type        = list(any)
  default     = []
}

variable "task_placement_constraints" {
  description = "The rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10"
  type = list(object({
    type       = string
    expression = string
  }))
  default = []
}

variable "service_placement_constraints" {
  description = "The rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10."
  type = list(object({
    type       = string
    expression = string
  }))
  default = []
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
  # type = list(object({
  #   container_name   = string
  #   container_port   = number
  #   elb_name         = optional(string)
  #   target_group_arn = string
  # }))
  type    = list(any)
  default = []
}

variable "service_registries" {
  description = "Service discovery registries for the service. The maximum number of service_registries blocks is 1"
  # type = list(object({
  #   registry_arn   = string
  #   container_name = string
  #   container_port = number
  #   port           = number
  # }))
  type    = list(any)
  default = []
}
