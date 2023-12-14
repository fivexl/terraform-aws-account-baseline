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
  default     = {}
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

variable "attach_access_log_delivery_policy" {
  type        = bool
  default     = false
  description = "Attach access log delivery policy to the bucket."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to be applied to the bucket."
}
