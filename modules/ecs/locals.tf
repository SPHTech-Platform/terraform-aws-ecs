locals {
  standard_tags = merge(
    { for k, v in var.standard_tags : "sph:${replace(k, "_", "-")}" => v if v != null && v != "" },
    { map-migrated = var.map_migrated },
  )
}