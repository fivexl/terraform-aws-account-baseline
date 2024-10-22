locals {
  s3_access_logs_glue_table_name   = var.s3_access_logs_glue_table.name != null ? var.s3_access_logs_glue_table.name : "s3_server_access_logs"
  name_with_hash                   = "athena-query-results-${sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))}"
  athena_query_results_bucket_name = length(local.name_with_hash) > 63 ? substr(name_with_hash, 0, 63) : name_with_hash
}
