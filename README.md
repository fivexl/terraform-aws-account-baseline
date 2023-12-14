# aws-account-baseline
The "aws-account-baseline" is an open-source Terraform module designed to provide a standardized foundational setup for AWS accounts. This module ensures that key security and management configurations are consistently applied across all your AWS accounts, establishing a robust and secure baseline.

## Features
- AWS IAM Account Alias: Sets a custom alias for your AWS account, enhancing clarity and identity management.
- AWS IAM Account Password Policy: Enforces a strong password policy for IAM users, bolstering account security.
- AWS S3 Account Public Access Block: Implements restrictions on public access to S3 buckets, safeguarding your data from unauthorized access.
- AWS IAM OpenID Connect Provider: Configures OpenID Connect provider for AWS IAM, facilitating identity federation.
- AWS EBS Encryption by Default: Activates default encryption on EBS volumes, ensuring data at rest is always encrypted.
- Terraform State Resources:
  -  Terraform State bucket
  -  Terraform DynamoDB state lock table
- Access Logs Bucket: Sets up an S3 bucket for storing access logs, providing critical insights for security and compliance.
- S3_baseline: presets S3 bucket with encryption, versioning, and other best practices

## Usage
This module is intended to be used in every AWS account as a set of "base settings" to ensure a consistent and secure environment. It's easily integrable into your existing AWS setup and can be customized to meet your specific needs.

```hcl
module "aws_account_baseline_account_level" {
  source = "github.com/fivexl/aws-account-baseline.git?ref=main/modules/account_level"
  aws_iam_account_alias = "test-management1"
}

module "aws_account_baseline_region_level" {
  source = "github.com/fivexl/aws-account-baseline.git?ref=main/modules/region_level"
  tags = module.tags.result
}

module "account_baseline_region_level_eu_central_1" {
  source = "github.com/fivexl/aws-account-baseline.git?ref=main/modules/region_level"
  providers = {
    aws = aws.eu_central_1
  }
  tags = module.tags.result
}
```