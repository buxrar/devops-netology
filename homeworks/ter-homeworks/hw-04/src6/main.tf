module "s3" {
  source          = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git"
  bucket_name = "simple-bucket-${random_string.unique_id.result}"
}
resource "random_string" "unique_id" {
  length  = 8
  upper   = false
  lower   = true
  numeric = true
  special = false
}

