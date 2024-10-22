output "athena_query_results_bucket_name" {
  value = module.athena_query_results_bucket.s3_bucket_id
}
