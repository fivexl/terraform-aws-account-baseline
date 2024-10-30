variable "s3_access_logs_glue_table" {
  description = "Configuration for the Glue table for the S3 access logs"
  type = object({
    name          = optional(string)
    database_name = optional(string)
    location      = string
  })
}

variable "s3_access_logs_bucket_name" {
  description = "The name of the S3 bucket for storing access logs"
  type        = string
}

variable "athena_query_results_bucket_name" {
  description = "The name of the S3 bucket for storing athena query results. Will be generated if not provided"
  type        = string
  default     = ""
}

variable "query_results_bucket_lifecycle_rule" {
  description = "The lifecycle rule for the query results bucket"
  type        = any
  default     = {}
}

variable "s3_access_logs_glue_database" {
  description = "Configuration for the Glue database for the S3 access logs"
  type = object({
    create = optional(bool, true)
    name   = optional(string, "s3_access_logs")
  })
  default = {
    create = true
    name   = "s3_access_logs"
  }
}

variable "create_athena_workgroup" {
  description = "Whether to create an Athena workgroup"
  type        = bool
  default     = true
}

variable "tags" {
  description = "(Optional) Key-value map of resource tags"
  type        = map(string)
  default     = {}
}
