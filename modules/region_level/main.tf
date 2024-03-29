resource "aws_ebs_encryption_by_default" "this" {
  enabled = true
}


# Tfsec are ignored because we don't want to end up with a circular logging in the access logs bucket, and we will
# protect bucket by other settings.
# We don't use our s3_baseline module here, because it enforces logging.
#tfsec:ignore:aws-s3-enable-bucket-logging
module "access_logs_bucket" {
  count   = var.create_s3_access_logs_bucket ? 1 : 0
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.0.1"

  bucket                               = local.access_logs_bucket_name
  versioning                           = var.s3_access_logs_bucket_versioning
  server_side_encryption_configuration = var.s3_access_logs_bucket_server_side_encryption_algorithm
  object_ownership                     = var.s3_access_logs_bucket_object_ownership
  control_object_ownership             = var.s3_access_logs_bucket_control_object_ownership
  block_public_acls                    = true
  block_public_policy                  = true
  ignore_public_acls                   = true
  restrict_public_buckets              = true
  tags                                 = merge(var.s3_access_logs_bucket_tags, var.tags)
  lifecycle_rule                       = var.s3_access_logs_bucket_lifecycle_rule

  attach_access_log_delivery_policy = var.s3_access_logs_bucket_attach_access_log_delivery_policy
  attach_elb_log_delivery_policy    = var.s3_access_logs_bucket_attach_elb_access_logs_policy
  attach_lb_log_delivery_policy     = var.s3_access_logs_bucket_attach_lb_log_delivery_policy

  replication_configuration         = var.s3_access_logs_bucket_replication_configuration
  attach_deny_incorrect_kms_key_sse = var.s3_access_logs_bucket_attach_deny_incorrect_kms_key_sse
  allowed_kms_key_arn               = var.s3_access_logs_bucket_allowed_kms_key_arn
}
