module "container_httpd" {
  source          = "cloudposse/ecs-container-definition/aws"
  version         = "0.58.1"
  container_name  = "container-httpd"
  container_image = "httpd:latest"

  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-group" : "/aws/ecs/ecs-${var.name}/contaner-httpd",
      "awslogs-region" : "ap-southeast-1",
      "awslogs-stream-prefix" : "aws",
      "awslogs-create-group" : "true"
    }
    secretOptions = null
  }
  port_mappings = [
    {
      "hostPort" : var.service_container_port,
      "protocol" : "tcp",
      "containerPort" : var.service_container_port
    }
  ]
  mount_points = [
    {
      containerPath = "/config"
      readOnly      = true
      sourceVolume  = "config_volume"
    }
  ]
  
  container_memory_reservation = 128
  environment                  = local.container_env_list
}