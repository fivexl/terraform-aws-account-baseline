locals {
  s3_tf_state_bucket_name    = "terraform-state-${sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))}"
  s3_access_logs_bucket_name = "access-logs-${sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))}"
  dynamodb_tf_state_lock_name = "terraform-state-lock-${sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))}"

  state_logging_configuration = var.create_s3_access_logs_bucket == true ? {
    target_bucket = var.s3_access_logs_bucket_name != "" ? var.s3_access_logs_bucket_name : local.s3_access_logs_bucket_name
    target_prefix = var.s3_tf_state_bucket_name
  } : {}
}