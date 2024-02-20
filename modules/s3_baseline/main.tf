# tfsec:ignore:aws-s3-enable-bucket-logging
module "bucket_baseline" {
  count   = var.create_bucket ? 1 : 0
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.0.1"

  bucket = var.bucket_name

  versioning                           = var.versioning
  server_side_encryption_configuration = var.server_side_encryption_configuration

  logging = {
    target_bucket = var.logging.target_bucket
    target_prefix = try(var.logging.target_prefix, "")
    target_object_key_format = {
      partitioned_prefix = {
        partition_date_source = "EventTime"
      }
    }
  }

  block_public_acls                 = true
  block_public_policy               = true
  ignore_public_acls                = true
  restrict_public_buckets           = true
  control_object_ownership          = var.control_object_ownership
  object_ownership                  = var.object_ownership
  attach_access_log_delivery_policy = var.attach_access_log_delivery_policy

  replication_configuration = var.replication_configuration

  tags = var.tags
}
