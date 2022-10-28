variable "vpc_id" {
  description = "The VPC identifier"
  type        = string

  validation {
    condition     = can(regex("^vpc-", var.vpc_id))
    error_message = "Wrong value for variable vpc_id."
  }
}
variable "enable_service_discovery" {
  description = "Whether to enable service discovery for tasks"
  type        = bool
  default     = true
}

variable "internal_dns_name" {
  description = "Internal DNS name, required when enabling service discovery"
  type        = string
  default     = ""
}
variable "service_discovery_routing_policy" {
  description = "The routing policy used in service discovery"
  type        = string
  default     = "MULTIVALUE"
}

variable "service_discovery_record_type" {
  description = "The DNS record type used in service discovery"
  type        = string
  default     = "A"
}

variable "service_discovery_record_ttl" {
  description = "The DNS record ttl used in service discovery"
  type        = number
  default     = 10
}

variable "service_discovery_health_check_failure_threshold" {
  type        = number
  description = "The health check failure threshold"
  default     = 1

  validation {
    condition     = var.service_discovery_health_check_failure_threshold <= 10
    error_message = "Maximum threshold value is 10."
  }
}

variable "service_names" {
  description = "List of service names to create service discovery"
  type        = list(string)
  default     = []
}
