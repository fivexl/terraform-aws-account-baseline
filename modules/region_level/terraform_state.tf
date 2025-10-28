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