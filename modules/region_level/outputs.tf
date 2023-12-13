output "state_bucket_arn" {
  description = "The ARN of the S3 bucket used for storing Terraform state"
  value       = try(module.terraform_state_bucket.s3_bucket_arn, "")
}

output "state_bucket_name" {
  description = "The ARN of the S3 bucket used for storing Terraform state"
  value       = try(module.terraform_state_bucket.s3_bucket_id, "")
}

output "dynamodb_state_lock_arn" {
  description = "The ARN of the DynamoDB table used for state locking"
  value       = try(aws_dynamodb_table.arn, "")
}

output "dynamodb_state_lock_name" {
  description = "The ARN of the DynamoDB table used for state locking"
  value       = try(aws_dynamodb_table.id, "")
}