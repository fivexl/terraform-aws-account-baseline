locals {
  default_s3_tf_state_bucket_name = "terraform-state-${sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))}"
  state_bucket_name               = var.s3_tf_state_bucket_name != "" ? var.s3_tf_state_bucket_name : local.default_s3_tf_state_bucket_name

  default_s3_access_logs_bucket_name = "access-logs-${sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))}"
  access_logs_bucket_name            = var.s3_access_logs_bucket_name != "" ? var.s3_access_logs_bucket_name : local.default_s3_access_logs_bucket_name

  default_cmk_access_logs_bucket_name = "cmk-access-logs-${sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))}"
  cmk_access_logs_bucket_name         = var.cmk_access_logs_bucket_config.bucket_name != "" ? var.cmk_access_logs_bucket_config.bucket_name : local.default_cmk_access_logs_bucket_name

  dynamodb_tf_state_lock_name = "terraform-state-lock-${sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))}"

  state_access_logs_cfg_is_empty = length(keys(var.s3_tf_state_bucket_logging)) < 1
  default_state_logging_configuration = var.create_s3_access_logs_bucket ? {
    target_bucket = local.access_logs_bucket_name
    target_prefix = ""
  } : {}
  state_logging_configuration = local.state_access_logs_cfg_is_empty ? local.default_state_logging_configuration : var.s3_tf_state_bucket_logging

  cmk_access_logs_access_logs_cfg_is_empty = length(keys(var.cmk_access_logs_bucket_config.logging)) < 1
  default_cmk_access_logs_logging_configuration = var.create_s3_access_logs_bucket ? {
    target_bucket = local.access_logs_bucket_name
    target_prefix = ""
  } : {}
  cmk_access_logs_logging_configuration = local.cmk_access_logs_access_logs_cfg_is_empty ? local.default_cmk_access_logs_logging_configuration : var.cmk_access_logs_bucket_config.logging
}
