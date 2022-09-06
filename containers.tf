locals {
  environment_list = [
    {
      name  = "ENVIRONMENT_TYPE"
      value = "dev"
    },
    {
      name  = "DOMAIN"
      value = "dev.awedio.sg.sg"
    }
  ]
}

### populate secret for container
# data "aws_secretsmanager_secret" "this" {
#   name = var.secret_arn
# }

# data "aws_secretsmanager_secret_version" "this" {
#   secret_id = data.aws_secretsmanager_secret.this.id
# }

module "container_awedio_nextjs" {
  source          = "cloudposse/ecs-container-definition/aws"
  version         = "0.58.1"
  container_name  = "awedio-nextjs"
  container_image = "653505252669.dkr.ecr.ap-southeast-1.amazonaws.com/awedio-dev:latest"

  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-group" : "/aws/ecs/ecs-radio-awedio-dev/awedio-nextjs",
      "awslogs-region" : "ap-southeast-1",
      "awslogs-stream-prefix" : "aws",
      "awslogs-create-group" : "true"
    }
    secretOptions = null
  }
  port_mappings = [
    {
      "hostPort" : 3000,
      "protocol" : "tcp",
      "containerPort" : 3000
    }
  ]
  container_memory_reservation = 128
  # secrets                      = local.drop_resolver_secrets_list
  environment = local.environment_list
}