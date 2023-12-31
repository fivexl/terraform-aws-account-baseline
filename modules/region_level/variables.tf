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



# ------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------
# Terraform state resources
variable "create_dynanodb_tf_state_lock" {
  type        = bool
  default     = true
  description = <<EOT
    If true, module will create DynamoDB table for storing Terraform state lock
    EOT
}

variable "create_s3_tf_state_bucket" {
  type        = bool
  default     = true
  description = "If true, module will create S3 bucket for storing Terraform state"
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

variable "dynamodb_tf_state_lock_server_side_encryption_enabled" {
  type        = bool
  default     = true
  description = "Enable server-side encryption for the DynamoDB table."
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

variable "dynamodb_tf_state_lock_tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the DynamoDB table."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to resources."
}
