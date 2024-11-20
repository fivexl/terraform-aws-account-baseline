locals {
  s3_access_logs_glue_table_name   = var.s3_access_logs_glue_table.name != null ? var.s3_access_logs_glue_table.name : "s3_server_access_logs"
  athena_query_results_bucket_name = var.athena_query_results_bucket_name != "" ? var.athena_query_results_bucket_name : module.naming_conventions.athena_query_results_bucket_name
}
