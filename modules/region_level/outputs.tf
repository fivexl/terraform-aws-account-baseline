output "state_bucket_arn" {
  description = "The ARN of the S3 bucket used for storing Terraform state"
  value       = try(module.terraform_state_bucket[0].s3_bucket_arn, "")
}

output "state_bucket_name" {
  description = "The ARN of the S3 bucket used for storing Terraform state"
  value       = try(module.terraform_state_bucket[0].s3_bucket_id, "")
}

output "access_logs_bucket_name" {
  description = "The name of the S3 bucket used for storing access logs"
  value       = try(module.logs_bucket.s3_bucket_id, "")
}

output "access_logs_bucket_arn" {
  description = "The ARN of the S3 bucket used for storing Terraform state"
  value       = try(module.logs_bucket.s3_bucket_arn, "")
}