module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 5.1"

  create = var.create

  # Autoscaling group
  name            = format("asg-%s", var.name)
  use_name_prefix = true
  instance_name   = format("ec2-asg-%s", var.instance_name)

  min_size                        = var.min_size
  max_size                        = var.max_size
  desired_capacity                = var.desired_capacity
  ignore_desired_capacity_changes = var.ignore_desired_capacity_changes
  wait_for_capacity_timeout       = var.wait_for_capacity_timeout
  protect_from_scale_in           = var.protect_from_scale_in
  health_check_type               = var.health_check_type
  vpc_zone_identifier             = var.subnets

  # Launch template
  create_launch_template      = true
  launch_template_name        = format("lt-%s", var.name)
  launch_template_description = var.launch_template_description
  update_default_version      = true

  image_id          = var.image_id
  instance_type     = var.instance_type
  ebs_optimized     = var.ebs_optimized
  enable_monitoring = var.enable_monitoring
  enabled_metrics   = var.enabled_metrics
  user_data_base64  = var.user_data_base64

  iam_instance_profile_arn = var.iam_instance_profile_arn

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = var.volume_size
        volume_type           = "gp2"
      }
    }
  ]

  capacity_reservation_specification = {
    capacity_reservation_preference = "open"
  }

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = var.network_interface_security_groups
    }
  ]

  placement = var.placement
  tags      = var.tags
}
