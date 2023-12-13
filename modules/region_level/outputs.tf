output "state_bucket_arn" {
  description = "The ARN of the S3 bucket used for storing Terraform state"
  value       = try(module.terraform_state.s3_bucket_arn, "")
}

output "state_bucket_name" {
  description = "The ARN of the S3 bucket used for storing Terraform state"
  value       = try(module.terraform_state.s3_bucket_id, "")
}

output "dynamodb_state_lock_arn" {
  description = "The ARN of the DynamoDB table used for state locking"
  value       = try(module.terraform_state.dynamodb_state_lock_arn, "")
}

output "dynamodb_state_lock_name" {
  description = "The ARN of the DynamoDB table used for state locking"
  value       = try(module.terraform_state.dynamodb_state_lock_name, "")
}