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
  attach_policy                = var.s3_access_logs_bucket_attach_policy
  policy                       = var.s3_access_logs_bucket_policy_attachment

  replication_configuration         = var.s3_access_logs_bucket_replication_configuration
  attach_deny_incorrect_kms_key_sse = var.s3_access_logs_bucket_attach_deny_incorrect_kms_key_sse
  allowed_kms_key_arn               = var.s3_access_logs_bucket_allowed_kms_key_arn

  attach_deny_insecure_transport_policy    = var.s3_access_logs_bucket_attach_deny_insecure_transport_policy
  attach_deny_incorrect_encryption_headers = var.s3_access_logs_bucket_attach_deny_incorrect_encryption_headers
  attach_deny_unencrypted_object_uploads   = var.s3_access_logs_bucket_attach_deny_unencrypted_object_uploads

  tags = merge(var.s3_access_logs_bucket_tags, var.tags)
}

module "cmk_access_logs_bucket" {
  source        = "../s3_baseline"
  create_bucket = var.cmk_access_logs_bucket_config.create_bucket
  logging       = local.cmk_access_logs_logging_configuration

  bucket_name                          = var.cmk_access_logs_bucket_config.bucket_name
  versioning                           = var.cmk_access_logs_bucket_config.versioning
  server_side_encryption_configuration = var.cmk_access_logs_bucket_config.server_side_encryption_configuration
  object_ownership                     = var.cmk_access_logs_bucket_config.object_ownership
  control_object_ownership             = var.cmk_access_logs_bucket_config.control_object_ownership
  lifecycle_rule                       = var.cmk_access_logs_bucket_config.lifecycle_rule

  attach_log_delivery_policies = var.cmk_access_logs_bucket_config.attach_log_delivery_policies
  attach_policy                = var.cmk_access_logs_bucket_config.attach_policy
  policy                       = var.cmk_access_logs_bucket_config.policy

  replication_configuration         = var.cmk_access_logs_bucket_config.replication_configuration
  attach_deny_incorrect_kms_key_sse = var.cmk_access_logs_bucket_config.attach_deny_incorrect_kms_key_sse
  allowed_kms_key_arn               = var.cmk_access_logs_bucket_config.allowed_kms_key_arn

  attach_deny_insecure_transport_policy    = var.cmk_access_logs_bucket_config.attach_deny_insecure_transport_policy
  attach_deny_incorrect_encryption_headers = var.cmk_access_logs_bucket_config.attach_deny_incorrect_encryption_headers
  attach_deny_unencrypted_object_uploads   = var.cmk_access_logs_bucket_config.attach_deny_unencrypted_object_uploads

  tags = merge(var.cmk_access_logs_bucket_config.tags, var.tags)
}
