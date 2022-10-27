variable "name" {
  description = "Name of the product/project/application"
  type        = string
  default     = ""
}

# variable "vpc_id" {
#   description = "The VPC identifier"
#   type        = string
#   default = ""

#   validation {
#     condition     = can(regex("^vpc-", var.vpc_id))
#     error_message = "Wrong value for variable vpc_id."
#   }
# }

variable "private_subnets" {
  description = "Private subnets for ECS"
  type        = list(string)
  default     = null
}

variable "aws_env" {
  description = "Environment the resource is being provisioned for"
  type        = string
  default = "example"
}

variable "aws_app_name" {
  description = "SPH app name under the product"
  type        = string
  default = ""
}

# tflint-ignore: terraform_unused_declarations
variable "aws_app_prefix" {
  description = "SPH app prefix for the system, easier to sort the resources"
  type        = string
  default = ""
}


# ##############################
# # ECS - service
# ##############################
variable "service_task_cpu" {
  description = "Number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required."
  type        = number
  default     = 256
}

variable "service_task_memory" {
  description = "Amount (in MiB) of memory used by the task. If the requires_compatibilities is FARGATE this field is required."
  type        = number
  default     = 512
}

variable "service_desired_count" {
  description = "Number of instances of the task definition to place and keep running."
  type        = number
  default     = 0
}

variable "service_container_port" {
  description = " Port on the container to associate with the load balancer."
  type        = string
  default = "80"
}

variable "service_task_execution_role_arn" {
  description = "IAM role for ECS execution"
  type        = string
  default = ""
}

################################################################################
# Autoscaling group
################################################################################
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

################################################################################
# Autoscaling group - launch template
################################################################################
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


variable "asg_volume_size" {
  description = "Specify the volume size for the root ebs"
  type        = string
  default = ""
}

variable "asg_iam_instance_profile_arn" {
  description = "The IAM Instance Profile ARN to launch the instance with"
  type        = string
  default     = null
}

################################################################################
# Container
################################################################################
variable "image_repo_name" {
  description = "Name of docker image from ECR"
  type        = string
  default = ""
}

################################################################################
# ALB details
################################################################################
variable "target_group_arns" {
  description = "List of target groups ARN, to be deleted"
  type        = list(string)
  default     = [""]
}

variable "lb_security_group_id" {
  description = "Security group for shared load balancer in nextjs stack"
  type        = string
  default     = ""
}
