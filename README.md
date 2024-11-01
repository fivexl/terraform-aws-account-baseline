[![FivexL](https://releases.fivexl.io/fivexlbannergit.jpg)](https://fivexl.io/)

# terraform-aws-account-baseline
The "terraform-aws-account-baseline" is an open-source Terraform module that offers a comprehensive and standardized setup for AWS accounts. This module is structured into three submodules: one for account-level configurations and another for regional settings, followed by the athena_regional_baseline for Athena-specific account settings. By applying this module, you establish a secure and robust baseline across your AWS accounts, ensuring key security and management configurations are uniformly applied.

## Features
**Account Level**
- AWS IAM Account Alias: Sets a custom alias for your AWS account, enhancing clarity and identity management.
- AWS IAM Account Password Policy: Enforces a strong password policy for IAM users, bolstering account security.
- AWS S3 Account Public Access Block: Implements restrictions on public access to S3 buckets, safeguarding your data from unauthorized access.
- AWS IAM OpenID Connect Provider: Configures OpenID Connect provider for AWS IAM, facilitating identity federation.
  
**Regional Level**
- EBS Encryption by Default: Activates default encryption on EBS volumes, ensuring data at rest is always encrypted.
- Block public EBS snapshot sharing: Prevents data exfiltration by publicly sharing EBS snapshots.
- Terraform State Resources:
  - Terraform State Bucket: Provides a secure location for storing Terraform state files.
  - Terraform DynamoDB State Lock Table: Ensures state file locking to prevent conflicts during Terraform operations.
- Access Logs Bucket: Sets up an S3 bucket for storing access logs, providing critical insights for security and compliance.
- S3_baseline: Presets S3 buckets with encryption, versioning, and other best practices for secure data storage and management.
- cmk_access_logs_bucket: Some logs, such as NLB access logs, cannot be encrypted using the default AWS-managed KMS key. Since we enforce encryption by default, we need an alternative location for these logs. This bucket serves as a dedicated repository for such access logs, ensuring they are stored securely.

**Athena Account Baseline**
- Athena Query Results Bucket: Establishes a dedicated S3 bucket for storing Athena query results, ensuring data is stored securely.
- Athena Workgroup: Creates an AWS Athena workgroup with the necessary configurations for secure and efficient query execution.
- Glue Catalog Database: Sets up a Glue catalog database for storing metadata, enabling efficient data querying and analysis.
- S3 Access Logs Glue Table: Creates a Glue table for storing S3 access logs, facilitating data analysis and monitoring.
- Query Results Bucket Lifecycle Rule: Allows you to define lifecycle rules for managing query results, ensuring efficient storage management.

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
  version = "1.3.7"
  aws_iam_account_alias = "test-management1"
}

module "account-baseline_region_level_primary_region" {
  source  = "fivexl/account-baseline/aws//modules/region_level"
  version = "1.3.7"
}

module "account-baseline_region_level_secondary_region" {
  source  = "fivexl/account-baseline/aws//modules/region_level"
  version = "1.3.7"
  providers = {
    aws = aws.eu_central_1
  }
}

module "athena_account_baseline_primary_region" {
  source = "fivexl/account-baseline/aws//modules/athena_account_baseline"
  version = "1.3.7"
  create_athena_workgroup    = true
  s3_access_logs_bucket_name = module.account-baseline_region_level_primary_region.access_logs_bucket_name
  s3_access_logs_glue_table = {
    location = "s3://${module.account-baseline_region_level_primary_region.access_logs_bucket_name}"
  }
  s3_access_logs_glue_database = {
    create = true
  }
  query_results_bucket_lifecycle_rule = local.query_results_bucket_lifecycle_rule
  tags      = tags
  providers = { aws = aws.primary }
}

module "athena_account_baseline_secondary_region" {
  source = "fivexl/account-baseline/aws//modules/athena_account_baseline"
  version = "1.3.7"
  create_athena_workgroup    = true
  s3_access_logs_bucket_name = module.account-baseline_region_level_secondary_region.access_logs_bucket_name
  s3_access_logs_glue_table = {
    location = "s3://${module.account-baseline_region_level_secondary_region.access_logs_bucket_name}"
  }
  s3_access_logs_glue_database = {
    create = true
  }
  query_results_bucket_lifecycle_rule = local.query_results_bucket_lifecycle_rule
  tags      = tags
  providers = { aws = aws.eu_central_1 }
}

locals {
  query_results_bucket_lifecycle_rule = [
    {
      id      = "/:Expire:After10D"
      enabled = true
      expiration = {
        days = 10
      }
      noncurrent_version_expiration = {
        days = 1
      }
    },
    {
      id      = "/:CleanUpDeleteMarkers:Immediate"
      enabled = true
      expiration = {
        expired_object_delete_marker = true
      }
    }
  ]
}
```

module
```

## Weekly review link
- [Review](https://github.com/fivexl/terraform-aws-account-baseline/compare/main@%7B7day%7D...main)
- [Review branch-based review](https://github.com/fivexl/terraform-aws-account-baseline/compare/review...main)
