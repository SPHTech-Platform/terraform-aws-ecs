module "container_httpd" {
  source          = "cloudposse/ecs-container-definition/aws"
  version         = "0.58.1"
  container_name  = "container-httpd"
  container_image = "httpd:latest"
  essential       = "true"

  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-group" : "/aws/ecs/${var.name}/contaner-httpd",
      "awslogs-region" : "ap-southeast-1",
      "awslogs-stream-prefix" : "aws",
      "awslogs-create-group" : "true"
    }
    secretOptions = null
  }
  port_mappings = [
    {
      "hostPort" : "80",
      "protocol" : "tcp",
      "containerPort" : "80"
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
