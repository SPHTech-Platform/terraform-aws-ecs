provider "aws" {
  region = "ap-southeast-1"

  allowed_account_ids = [
    "653505252669",
  ]

  default_tags {
    tags = {
      "sph:env"         = "dev"
      "sph:app-tier"    = "2"
      "sph:appteam"     = "Radio Applications"
      "sph:cost-centre" = "1111"
      "sph:product"     = "awedio"
      "sph:biz-dept"    = "Radio Applications"
      "map-migrated"    = "d-server-00fyc0pr7gc8hv"
    }
  }
}