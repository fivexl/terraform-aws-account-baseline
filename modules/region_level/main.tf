resource "aws_ebs_encryption_by_default" "this" {
  enabled = true
}

module "logs_bucket" {
  source            = "../s3_baseline"
  create_bucket     = var.create_s3_access_logs_bucket
  is_logging_bucket = true
  logging           = {}

  bucket_name                          = local.access_logs_bucket_name
  versioning                           = var.s3_access_logs_bucket_versioning
  server_side_encryption_configuration = var.s3_access_logs_bucket_server_side_encryption_algorithm
  object_ownership                     = var.s3_access_logs_bucket_object_ownership
  control_object_ownership             = var.s3_access_logs_bucket_control_object_ownership
  lifecycle_rule                       = var.s3_access_logs_bucket_lifecycle_rule

  attach_log_delivery_policies = var.s3_access_logs_bucket_attach_log_delivery_policies
  policy                       = var.s3_access_logs_bucket_policy_attachment

  replication_configuration         = var.s3_access_logs_bucket_replication_configuration
  attach_deny_incorrect_kms_key_sse = var.s3_access_logs_bucket_attach_deny_incorrect_kms_key_sse
  allowed_kms_key_arn               = var.s3_access_logs_bucket_allowed_kms_key_arn

  attach_deny_insecure_transport_policy    = var.s3_access_logs_bucket_attach_deny_insecure_transport_policy
  attach_deny_incorrect_encryption_headers = var.s3_access_logs_bucket_attach_deny_incorrect_encryption_headers
  attach_deny_unencrypted_object_uploads   = var.s3_access_logs_bucket_attach_deny_unencrypted_object_uploads

  tags = merge(var.s3_access_logs_bucket_tags, var.tags)
}
