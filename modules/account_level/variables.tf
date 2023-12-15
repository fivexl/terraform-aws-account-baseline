
# ------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------
# S3 Public Access Block

variable "create_s3_account_public_access_block" {
  type        = bool
  default     = true
  description = "If true, module will create S3 public access block for account"
}

variable "s3_account_public_access_block_public_acls" {
  type        = bool
  default     = true
  description = <<EOT
    (Optional) Whether Amazon S3 should block public ACLs for buckets in this account. Defaults to false. Enabling this setting does not affect existing policies or ACLs. When set to true causes the following behavior:
      PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access.
      PUT Object calls fail if the request includes a public ACL.
  EOT
}

variable "s3_account_public_access_block_public_policy" {
  type        = bool
  default     = true
  description = <<EOT
    (Optional) Whether Amazon S3 should block public bucket policies for buckets in this account. Defaults to false. Enabling this setting does not affect existing bucket policies. When set to true causes Amazon S3 to:
    Reject calls to PUT Bucket policy if the specified bucket policy allows public access.
  EOT
}

variable "s3_account_public_access_block_ignore_public_acls" {
  type        = bool
  default     = true
  description = <<EOT
    (Optional) Whether Amazon S3 should ignore public ACLs for buckets in this account. Defaults to false. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to true causes Amazon S3 to:
      Ignore all public ACLs on buckets in this account and any objects that they contain.
  EOT
}

variable "s3_account_public_access_block_restrict_public_buckets" {
  type        = bool
  default     = true
  description = <<EOT
    (Optional) Whether Amazon S3 should restrict public bucket policies for buckets in this account. Defaults to false. Enabling this setting does not affect previously stored bucket policies, except that public and cross-account access within any public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true:
      Only the bucket owner and AWS Services can access buckets with public policies.
  EOT
}

variable "aws_iam_account_alias" {
  type        = string
  description = "The AWS IAM account alias to set for the account, by default it will be set to the account name"
  default     = ""
}

variable "create_iam_account_password_policy" {
  type        = bool
  description = "Whether to create an IAM account password policy"
  default     = true
}
