variable "name" {
  description = "Name of the product/project/application"
  type        = string
  default     = "ecs-ec2-example"
}

# ##############################
# # ECS - service
# ##############################
variable "service_container_port" {
  description = " Port on the container to associate with the load balancer."
  type        = string
  default     = "80"
}
