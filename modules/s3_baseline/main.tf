# tfsec:ignore:aws-s3-enable-bucket-logging
module "bucket_baseline" {
  count   = var.create_bucket ? 1 : 0
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.2.1"

  bucket = var.bucket_name

  versioning                           = var.versioning
  server_side_encryption_configuration = var.server_side_encryption_configuration

  logging = var.is_logging_bucket ? tomap({}) : {
    target_bucket = var.logging.target_bucket
    target_prefix = try(var.logging.target_prefix, "")
    target_object_key_format = {
      partitioned_prefix = {
        partition_date_source = "EventTime"
      }
    }
  }

  block_public_acls        = true
  block_public_policy      = true
  ignore_public_acls       = true
  restrict_public_buckets  = true
  control_object_ownership = var.control_object_ownership
  object_ownership         = var.object_ownership
  lifecycle_rule           = var.lifecycle_rule

  attach_policy = var.policy != null ? true : false
  policy        = var.policy

  object_lock_configuration = var.object_lock_configuration
  object_lock_enabled       = var.object_lock_enabled

  attach_access_log_delivery_policy = var.attach_log_delivery_policies
  attach_elb_log_delivery_policy    = var.attach_log_delivery_policies
  attach_lb_log_delivery_policy     = var.attach_log_delivery_policies

  attach_deny_insecure_transport_policy    = var.attach_deny_insecure_transport_policy
  attach_deny_incorrect_encryption_headers = var.attach_deny_incorrect_encryption_headers
  attach_deny_unencrypted_object_uploads   = var.attach_deny_unencrypted_object_uploads

  attach_deny_incorrect_kms_key_sse = var.attach_deny_incorrect_kms_key_sse
  allowed_kms_key_arn               = var.allowed_kms_key_arn

  replication_configuration = var.replication_configuration

  tags = var.tags
}
