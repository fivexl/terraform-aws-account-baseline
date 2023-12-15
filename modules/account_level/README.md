# Account level baseline module

## Overview
The terraform-aws-account-baseline module is designed to implement best practices for AWS account management using Terraform. It ensures a secure and standardized configuration for your AWS account.

## Included Resources
- aws_iam_account_alias: Sets a user-friendly alias for your AWS account login URL.
- aws_iam_account_password_policy: Establishes a robust password policy for IAM users, enforcing password complexity and rotation policies.
- aws_s3_account_public_access_block: Applies account-level blocks to prevent public access to S3 buckets, enhancing data security.
- aws_iam_openid_connect_provider: Configures an OpenID Connect (OIDC) provider for AWS IAM, facilitating identity federation.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.27.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.30.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_account_alias.alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_alias) | resource |
| [aws_iam_account_password_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |
| [aws_iam_openid_connect_provider.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_s3_account_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_account_public_access_block) | resource |
| [tls_certificate.github_actions_oidc_provider](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_iam_account_alias"></a> [aws\_iam\_account\_alias](#input\_aws\_iam\_account\_alias) | The AWS IAM account alias to set for the account, by default it will be set to the account name | `string` | `""` | no |
| <a name="input_create_iam_account_password_policy"></a> [create\_iam\_account\_password\_policy](#input\_create\_iam\_account\_password\_policy) | Whether to create an IAM account password policy | `bool` | `true` | no |
| <a name="input_create_s3_account_public_access_block"></a> [create\_s3\_account\_public\_access\_block](#input\_create\_s3\_account\_public\_access\_block) | If true, module will create S3 public access block for account | `bool` | `true` | no |
| <a name="input_s3_account_public_access_block_ignore_public_acls"></a> [s3\_account\_public\_access\_block\_ignore\_public\_acls](#input\_s3\_account\_public\_access\_block\_ignore\_public\_acls) | (Optional) Whether Amazon S3 should ignore public ACLs for buckets in this account. Defaults to false. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to true causes Amazon S3 to:<br>      Ignore all public ACLs on buckets in this account and any objects that they contain. | `bool` | `true` | no |
| <a name="input_s3_account_public_access_block_public_acls"></a> [s3\_account\_public\_access\_block\_public\_acls](#input\_s3\_account\_public\_access\_block\_public\_acls) | (Optional) Whether Amazon S3 should block public ACLs for buckets in this account. Defaults to false. Enabling this setting does not affect existing policies or ACLs. When set to true causes the following behavior:<br>      PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access.<br>      PUT Object calls fail if the request includes a public ACL. | `bool` | `true` | no |
| <a name="input_s3_account_public_access_block_public_policy"></a> [s3\_account\_public\_access\_block\_public\_policy](#input\_s3\_account\_public\_access\_block\_public\_policy) | (Optional) Whether Amazon S3 should block public bucket policies for buckets in this account. Defaults to false. Enabling this setting does not affect existing bucket policies. When set to true causes Amazon S3 to:<br>    Reject calls to PUT Bucket policy if the specified bucket policy allows public access. | `bool` | `true` | no |
| <a name="input_s3_account_public_access_block_restrict_public_buckets"></a> [s3\_account\_public\_access\_block\_restrict\_public\_buckets](#input\_s3\_account\_public\_access\_block\_restrict\_public\_buckets) | (Optional) Whether Amazon S3 should restrict public bucket policies for buckets in this account. Defaults to false. Enabling this setting does not affect previously stored bucket policies, except that public and cross-account access within any public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true:<br>      Only the bucket owner and AWS Services can access buckets with public policies. | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
