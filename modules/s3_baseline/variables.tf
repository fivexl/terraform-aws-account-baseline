variable "create_bucket" {
  type        = bool
  default     = true
  description = "If true, module will create S3 bucket, with predefined best practices."
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket."
}

variable "logging" {
  type        = map(string)
  description = "Map containing access bucket logging configuration."
}

variable "versioning" {
  type        = any
  default     = { enabled = true }
  description = "Enable versioning for the S3 bucket."
}

variable "server_side_encryption_configuration" {
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

variable "control_object_ownership" {
  type        = bool
  default     = true
  description = "Control object ownership for the bucket."
}

variable "object_ownership" {
  type        = string
  default     = "BucketOwnerEnforced"
  description = "The type of object ownership for the bucket."
}

variable "attach_log_delivery_policies" {
  type        = bool
  default     = false
  description = "Attach S3/VPC/NLB/ALB/ELB access log delivery policy to the bucket."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to be applied to the bucket."
}

variable "replication_configuration" {
  type        = any
  default     = {}
  description = "Replication configuration for the S3 bucket."
}

variable "attach_deny_incorrect_kms_key_sse" {
  description = "Controls if S3 bucket policy should deny usage of incorrect KMS key SSE."
  type        = bool
  default     = false
}

variable "allowed_kms_key_arn" {
  description = "The ARN of KMS key which should be allowed in PutObject"
  type        = string
  default     = null
}

variable "lifecycle_rule" {
  type        = any
  description = "List of maps containing configuration of object lifecycle management."
  default     = []
}

variable "is_logging_bucket" {
  description = "If this bucket is a logging bucket, we may not need to enable logging, to not end up with access logs delivered to themselves."
  type        = bool
  default     = false
}

variable "policy" {
  type        = any
  default     = null
  description = "The policy to apply to the S3 bucket."
}

variable "attach_deny_insecure_transport_policy" {
  description = "Controls if S3 bucket policy should deny insecure transport (HTTP) requests."
  type        = bool
  default     = true
}

variable "attach_deny_incorrect_encryption_headers" {
  description = "Controls if S3 bucket policy should deny requests with incorrect encryption headers."
  type        = bool
  default     = true
}

variable "attach_deny_unencrypted_object_uploads" {
  description = "Controls if S3 bucket policy should deny unencrypted object uploads."
  type        = bool
  default     = true
}
