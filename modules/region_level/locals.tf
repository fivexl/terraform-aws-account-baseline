locals {
  s3_tf_state_bucket_name    = "terraform-state-${sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))}"
  state_bucket_name = var.s3_tf_state_bucket_name != "" ? var.s3_tf_state_bucket_name : local.s3_tf_state_bucket_name

  s3_access_logs_bucket_name = "access-logs-${sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))}"
  dynamodb_tf_state_lock_name = "terraform-state-lock-${sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))}"

  default_logging_configuration = {
    target_bucket = var.create_s3_access_logs_bucket ? (var.s3_access_logs_bucket_name != "" ? var.s3_access_logs_bucket_name : local.s3_access_logs_bucket_name) : null
    target_prefix = var.create_s3_access_logs_bucket ? local.state_bucket_name : null
  }
  state_logging_configuration = length(var.s3_tf_state_bucket_logging) > 0 ? var.s3_tf_state_bucket_logging : local.default_logging_configuration
}