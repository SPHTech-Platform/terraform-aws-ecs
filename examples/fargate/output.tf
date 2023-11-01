output "ecs_cluster_kms_arn" {
  value       = module.fargate_cluster.ecs_cluster_kms_arn
  description = "The AWS Key Management Service key ID to encrypt the data between the local client and the container"
}
