locals {
  # tflint-ignore: terraform_unused_declarations
  stack = "httpd"

  container_env_list = [
    {
      name  = "ENVIRONMENT_TYPE"
      value = "Example"
    }
  ]

  service_map = {
    httpd = {
      create          = true
      service_scaling = true
      service_container_definitions = jsonencode([
        module.container_httpd.json_map_object
      ])
      service_task_cpu      = 256
      service_task_memory   = 512
      service_desired_count = 4
      service_deployment_maximum_percent = 600
      service_deployment_minimum_healthy_percent = 100
      ecs_load_balancers = [
        {
          target_group_arn = element(module.alb.target_group_arns, 0),
          container_name   = "container-httpd",
          container_port   = var.service_container_port
        }
      ]
      docker_volumes = [
        {
          name = "config_volume"
        }
      ]
    }
  }
}
