module "terraform_state_bucket" {
  source = "../s3_baseline"
  count  = var.create_s3_tf_state_bucket ? 1 : 0

  logging                              = local.state_logging_configuration
  bucket_name                          = local.state_bucket_name
  versioning                           = var.s3_tf_state_bucket_versioning
  server_side_encryption_configuration = var.s3_tf_state_bucket_server_side_encryption_configuration

  tags                              = merge(var.s3_tf_state_bucket_tags, var.tags)
  attach_deny_incorrect_kms_key_sse = var.s3_tf_state_bucket_attach_deny_incorrect_kms_key_sse
  allowed_kms_key_arn               = var.s3_tf_state_bucket_allowed_kms_key_arn
  lifecycle_rule = [
    { # to deal with SecurityHub 'no lifecycle rules configured' control for tf-state buckets
      id                                     = "/:AbortIncompleteUploads:After7D"
      enabled                                = true
      prefix                                 = "/"
      abort_incomplete_multipart_upload_days = 7
    },
  ]
}

# tfsec:ignore:aws-dynamodb-enable-recovery
module "dynamodb_tf_state_lock" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "4.0.1"
  count   = var.create_dynamodb_tf_state_lock ? 1 : 0

  name = var.dynamodb_tf_state_lock_name != "" ? var.dynamodb_tf_state_lock_name : local.dynamodb_tf_state_lock_name

  hash_key     = var.dynamodb_tf_state_lock_hash_key
  billing_mode = var.dynamodb_tf_state_lock_billing_mode

  point_in_time_recovery_enabled = true
  deletion_protection_enabled    = var.dynamodb_tf_state_lock_deletion_protection_enabled

  server_side_encryption_enabled     = var.dynamodb_tf_state_lock_server_side_encryption_enabled
  server_side_encryption_kms_key_arn = var.dynamodb_tf_state_lock_server_side_encryption_kms_key_arn

  attributes = var.dynamodb_tf_state_lock_attribute

  tags = merge(var.dynamodb_tf_state_lock_tags, var.tags)
}
