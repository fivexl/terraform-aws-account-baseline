# ------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------
# Access logs bucket

variable "create_s3_access_logs_bucket" {
  type        = bool
  default     = true
  description = "If true, module will create S3 bucket for storing access logs"
}

variable "s3_access_logs_bucket_name" {
  type        = string
  default     = ""
  description = <<EOT
  The name of the S3 bucket.
  If not specified, the module will generate a name automatically like:
  "access-logs-{sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))}"
  EOT
}

variable "s3_access_logs_bucket_versioning" {
  type        = any
  default     = { enabled = true }
  description = "Enable versioning for the S3 bucket."
}

variable "s3_access_logs_bucket_server_side_encryption_algorithm" {
  type = any
  default = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  description = "The server-side encryption algorithm to use for the S3 bucket."
}

variable "s3_access_logs_bucket_control_object_ownership" {
  type        = bool
  default     = true
  description = "Control object ownership for the S3 access logs bucket."
}

variable "s3_access_logs_bucket_object_ownership" {
  type        = string
  default     = "BucketOwnerEnforced"
  description = "The type of object ownership for the S3 access logs bucket."
}

variable "s3_access_logs_bucket_tags" {
  type        = map(string)
  default     = {}
  description = "Tags to be applied to the S3 access logs bucket."
}

variable "s3_access_logs_bucket_replication_configuration" {
  type        = any
  default     = {}
  description = "Replication configuration for the S3 bucket."
}

variable "s3_access_logs_bucket_attach_deny_incorrect_kms_key_sse" {
  description = "Controls if S3 bucket policy should deny usage of incorrect KMS key SSE."
  type        = bool
  default     = false
}

variable "s3_access_logs_bucket_allowed_kms_key_arn" {
  description = "The ARN of KMS key which should be allowed in PutObject"
  type        = string
  default     = null
}

variable "s3_access_logs_bucket_lifecycle_rule" {
  type        = any
  description = "List of maps containing configuration of object lifecycle management."
  default     = []
}

variable "s3_access_logs_bucket_attach_log_delivery_policies" {
  type        = bool
  default     = true
  description = "Attach S3/VPC/NLB/ALB/ELB access log delivery policy to the bucket."
}

variable "s3_access_logs_bucket_policy_attachment" {
  type        = any
  default     = null
  description = "The policy to apply to the logs bucket."
}


# ------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------
# Terraform state resources
variable "create_dynamodb_tf_state_lock" {
  type        = bool
  default     = true
  description = <<EOT
    If true, module will create DynamoDB table for storing Terraform state lock
    EOT
}

variable "dynamodb_tf_state_lock_name" {
  type        = string
  default     = ""
  description = <<EOT
  The name of the DynamoDB table.
  If not specified, the module will generate a name automatically like:
  "terraform-state-{sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))}"
  EOT
}

variable "dynamodb_tf_state_lock_hash_key" {
  type        = string
  default     = "LockID"
  description = "The hash key for the DynamoDB table."
}

variable "dynamodb_tf_state_lock_billing_mode" {
  type        = string
  default     = "PAY_PER_REQUEST"
  description = "The billing mode for the DynamoDB table."
}

variable "dynamodb_tf_state_lock_attribute" {
  type = list(object({
    name = string
    type = string
  }))
  default = [
    {
      name = "LockID",
      type = "S"
    }
  ]
  description = "The attributes for the DynamoDB table."
}

variable "dynamodb_tf_state_lock_tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the DynamoDB table."
}

variable "dynamodb_tf_state_lock_server_side_encryption_enabled" {
  type        = bool
  default     = true
  description = "Enable server-side encryption for the DynamoDB table."
}

variable "dynamodb_tf_state_lock_server_side_encryption_kms_key_arn" {
  description = "The ARN of the CMK that should be used for the AWS KMS encryption. This attribute should only be specified if the key is different from the default DynamoDB CMK, alias/aws/dynamodb."
  type        = string
  default     = null
}

variable "dynamodb_tf_state_lock_deletion_protection_enabled" {
  description = "Whether to enable deletion protection on the DynamoDB table"
  type        = bool
  default     = true
}

variable "create_s3_tf_state_bucket" {
  type        = bool
  default     = true
  description = "If true, module will create S3 bucket for storing Terraform state"
}

variable "s3_tf_state_bucket_name" {
  type        = string
  default     = ""
  description = <<EOT
  The name of the S3 bucket.
  If not specified, the module will generate a name automatically like:
  "terraform-state-{sha1(format("%s-%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name))}"
  EOT
}

variable "s3_tf_state_bucket_logging" {
  type        = map(string)
  default     = {}
  description = "Logging settings for the S3 bucket. By default, module will use acess logs bucket."
}

variable "s3_tf_state_bucket_versioning" {
  type        = any
  default     = { enabled = true }
  description = "Enable versioning for the S3 bucket."
}

variable "s3_tf_state_bucket_tags" {
  type        = map(string)
  default     = {}
  description = "Tags to be applied to the S3 bucket."
}

variable "s3_tf_state_bucket_attach_deny_incorrect_kms_key_sse" {
  description = "Controls if S3 bucket policy should deny usage of incorrect KMS key SSE."
  type        = bool
  default     = false
}

variable "s3_tf_state_bucket_allowed_kms_key_arn" {
  description = "The ARN of KMS key which should be allowed in PutObject"
  type        = string
  default     = null
}

variable "s3_tf_state_bucket_server_side_encryption_configuration" {
  type = any
  default = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  description = "The server-side encryption algorithm to use for the S3 bucket."
}

# ------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to resources."
}
