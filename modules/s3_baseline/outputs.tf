output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket used for storing Terraform state"
  value       = try(module.bucket_baseline[0].s3_bucket_arn, "")
}

output "s3_bucket_id" {
  description = "The Name of the S3 bucket used for storing Terraform state"
  value       = try(module.bucket_baseline[0].s3_bucket_id, "")
}
