[![FivexL](https://releases.fivexl.io/fivexlbannergit.jpg)](https://fivexl.io/)

# terraform-aws-account-baseline
The "terraform-aws-account-baseline" is an open-source Terraform module that offers a comprehensive and standardized setup for AWS accounts. This module is structured into two submodules: one for account-level configurations and another for regional settings. By applying this module, you establish a secure and robust baseline across your AWS accounts, ensuring key security and management configurations are uniformly applied.

## Features
**Account Level**
- AWS IAM Account Alias: Sets a custom alias for your AWS account, enhancing clarity and identity management.
- AWS IAM Account Password Policy: Enforces a strong password policy for IAM users, bolstering account security.
- AWS S3 Account Public Access Block: Implements restrictions on public access to S3 buckets, safeguarding your data from unauthorized access.
- AWS IAM OpenID Connect Provider: Configures OpenID Connect provider for AWS IAM, facilitating identity federation.
  
**Regional Level**
- AWS EBS Encryption by Default: Activates default encryption on EBS volumes, ensuring data at rest is always encrypted.
- Terraform State Resources:
  - Terraform State Bucket: Provides a secure location for storing Terraform state files.
  - Terraform DynamoDB State Lock Table: Ensures state file locking to prevent conflicts during Terraform operations.
- Access Logs Bucket: Sets up an S3 bucket for storing access logs, providing critical insights for security and compliance.
- S3_baseline: Presets S3 buckets with encryption, versioning, and other best practices for secure data storage and management.
- cmk_access_logs_bucket: Some logs, such as NLB access logs, cannot be encrypted using the default AWS-managed KMS key. Since we enforce encryption by default, we need an alternative location for these logs. This bucket serves as a dedicated repository for such access logs, ensuring they are stored securely.

## Usage
This modular setup is designed for integration across all AWS accounts, providing a set of "base settings" for a consistent and secure environment. It can be customized to align with specific organizational needs and easily incorporated into your existing AWS infrastructure.

## Example Usage
```hcl
provider "aws" {
  alias  = "eu_central_1"
  region = "eu-central-1"
}

module "account-baseline_account_level" {
  source  = "fivexl/account-baseline/aws//modules/account_level"
  version = "1.0.0"
  aws_iam_account_alias = "test-management1"
}

module "account-baseline_region_level" {
  source  = "fivexl/account-baseline/aws//modules/region_level"
  version = "1.0.0"
}

module "account-baseline_region_level_eu_central_1" {
  source  = "fivexl/account-baseline/aws//modules/region_level"
  version = "1.0.0"
  providers = {
    aws = aws.eu_central_1
  }
}
```

## Weekly review link
- [Review](https://github.com/fivexl/terraform-aws-account-baseline/compare/main@%7B7day%7D...main)
- [Review branch-based review](https://github.com/fivexl/terraform-aws-account-baseline/compare/review...main)
