module "bucket_baseline" {
  count   = var.create_bucket ? 1 : 0
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.15.1"

  bucket = var.bucket_name

  versioning                           = var.versioning
  server_side_encryption_configuration = var.server_side_encryption_configuration

  block_public_acls                 = true
  block_public_policy               = true
  ignore_public_acls                = true
  restrict_public_buckets           = true
  control_object_ownership          = var.control_object_ownership
  object_ownership                  = var.object_ownership
  attach_access_log_delivery_policy = var.attach_access_log_delivery_policy

  tags = var.tags
}

# Logging done via resource, because for now module does not support new Date-based partitioning feature
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging#target_object_key_format
# 2023.12.11
resource "aws_s3_bucket_logging" "this" {
  count = var.create_bucket && length(keys(var.logging)) > 0 ? 1 : 0

  bucket = module.bucket_baseline[0].s3_bucket_id

  target_bucket = var.logging.target_bucket
  target_prefix = try(var.logging.target_prefix, null)

  target_object_key_format {
    partitioned_prefix {
      partition_date_source = "EventTime"
    }
  }
}
