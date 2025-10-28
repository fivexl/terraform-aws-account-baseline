# Aws_account_baseline region level module

## Overview
The terraform-aws-regional-baseline module is a Terraform solution designed for setting up essential regional resources in AWS with a focus on security and best practices. This configuration helps in maintaining a secure and efficient AWS environment at the regional level.

## Included Resources
- aws_ebs_encryption_by_default: Automatically enables encryption for new EBS volumes and snapshots created in the region.
- aws_ebs_snapshot_block_public_access: Disables the ability to create public snapshots in the region.
- terraform_state_bucket: Creates an S3 bucket designed to store Terraform state files securely.
- aws_dynamodb_table: Sets up a DynamoDB table, used for locking Terraform state files to prevent conflicts.
- access_logs_bucket: Establishes an S3 bucket for storing access logs, assisting in monitoring and auditing activities.
- cmk_access_logs_bucket: Some logs, such as NLB access logs, cannot be encrypted using the default AWS-managed KMS key. Since we enforce encryption by default, we need an alternative location for these logs. This bucket serves as a dedicated repository for such access logs, ensuring they are stored securely.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0.0, < 7.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.18.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cmk_access_logs_bucket"></a> [cmk\_access\_logs\_bucket](#module\_cmk\_access\_logs\_bucket) | ../s3_baseline | n/a |
| <a name="module_logs_bucket"></a> [logs\_bucket](#module\_logs\_bucket) | ../s3_baseline | n/a |
| <a name="module_terraform_state_bucket"></a> [terraform\_state\_bucket](#module\_terraform\_state\_bucket) | ../s3_baseline | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ebs_encryption_by_default.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_encryption_by_default) | resource |
| [aws_ebs_snapshot_block_public_access.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_snapshot_block_public_access) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cmk_access_logs_bucket_config"></a> [cmk\_access\_logs\_bucket\_config](#input\_cmk\_access\_logs\_bucket\_config) | Configuration for the CMK (Customer Master Key) access logs bucket.<br/>- bucket\_name: The name of the S3 bucket. If not specified, the module will generate a name automatically.<br/>- logging: If not specified and access logs bucket is created, the module will create a logging configuration that targets the access logs bucket.<br/>- server\_side\_encryption\_configuration: It is not set to default, so you will be able to create the bucket and specify the encryption algorithm and the KMS key later. | <pre>object({<br/>    create_bucket                            = optional(bool, false)<br/>    bucket_name                              = optional(string, "")<br/>    versioning                               = optional(any, { enabled = true })<br/>    server_side_encryption_configuration     = optional(any, {})<br/>    logging                                  = optional(any, {})<br/>    lifecycle_rule                           = optional(any, [])<br/>    replication_configuration                = optional(any, {})<br/>    object_ownership                         = optional(string, "BucketOwnerEnforced")<br/>    control_object_ownership                 = optional(bool, true)<br/>    allowed_kms_key_arn                      = optional(string, null)<br/>    policy                                   = optional(any, null)<br/>    attach_log_delivery_policies             = optional(bool, true)<br/>    attach_deny_incorrect_kms_key_sse        = optional(bool, false)<br/>    attach_deny_insecure_transport_policy    = optional(bool, true)<br/>    attach_deny_unencrypted_object_uploads   = optional(bool, true)<br/>    attach_deny_incorrect_encryption_headers = optional(bool, true)<br/>    tags                                     = optional(map(string), {})<br/>  })</pre> | `{}` | no |
| <a name="input_create_s3_access_logs_bucket"></a> [create\_s3\_access\_logs\_bucket](#input\_create\_s3\_access\_logs\_bucket) | If true, module will create S3 bucket for storing access logs | `bool` | `true` | no |
| <a name="input_create_s3_tf_state_bucket"></a> [create\_s3\_tf\_state\_bucket](#input\_create\_s3\_tf\_state\_bucket) | If true, module will create S3 bucket for storing Terraform state | `bool` | `true` | no |
| <a name="input_s3_access_logs_bucket_allowed_kms_key_arn"></a> [s3\_access\_logs\_bucket\_allowed\_kms\_key\_arn](#input\_s3\_access\_logs\_bucket\_allowed\_kms\_key\_arn) | The ARN of KMS key which should be allowed in PutObject | `string` | `null` | no |
| <a name="input_s3_access_logs_bucket_attach_deny_incorrect_encryption_headers"></a> [s3\_access\_logs\_bucket\_attach\_deny\_incorrect\_encryption\_headers](#input\_s3\_access\_logs\_bucket\_attach\_deny\_incorrect\_encryption\_headers) | Controls if S3 bucket policy should deny requests with incorrect encryption headers. | `bool` | `false` | no |
| <a name="input_s3_access_logs_bucket_attach_deny_incorrect_kms_key_sse"></a> [s3\_access\_logs\_bucket\_attach\_deny\_incorrect\_kms\_key\_sse](#input\_s3\_access\_logs\_bucket\_attach\_deny\_incorrect\_kms\_key\_sse) | Controls if S3 bucket policy should deny usage of incorrect KMS key SSE. | `bool` | `false` | no |
| <a name="input_s3_access_logs_bucket_attach_deny_insecure_transport_policy"></a> [s3\_access\_logs\_bucket\_attach\_deny\_insecure\_transport\_policy](#input\_s3\_access\_logs\_bucket\_attach\_deny\_insecure\_transport\_policy) | Controls if S3 bucket policy should deny insecure transport (HTTP) requests. | `bool` | `true` | no |
| <a name="input_s3_access_logs_bucket_attach_deny_unencrypted_object_uploads"></a> [s3\_access\_logs\_bucket\_attach\_deny\_unencrypted\_object\_uploads](#input\_s3\_access\_logs\_bucket\_attach\_deny\_unencrypted\_object\_uploads) | Controls if S3 bucket policy should deny unencrypted object uploads. | `bool` | `false` | no |
| <a name="input_s3_access_logs_bucket_attach_log_delivery_policies"></a> [s3\_access\_logs\_bucket\_attach\_log\_delivery\_policies](#input\_s3\_access\_logs\_bucket\_attach\_log\_delivery\_policies) | Attach S3/VPC/NLB/ALB/ELB access log delivery policy to the bucket. | `bool` | `true` | no |
| <a name="input_s3_access_logs_bucket_control_object_ownership"></a> [s3\_access\_logs\_bucket\_control\_object\_ownership](#input\_s3\_access\_logs\_bucket\_control\_object\_ownership) | Control object ownership for the S3 access logs bucket. | `bool` | `true` | no |
| <a name="input_s3_access_logs_bucket_lifecycle_rule"></a> [s3\_access\_logs\_bucket\_lifecycle\_rule](#input\_s3\_access\_logs\_bucket\_lifecycle\_rule) | List of maps containing configuration of object lifecycle management. | `any` | `[]` | no |
| <a name="input_s3_access_logs_bucket_name"></a> [s3\_access\_logs\_bucket\_name](#input\_s3\_access\_logs\_bucket\_name) | The name of the S3 bucket.<br/>  If not specified, the module will generate a name automatically like:<br/>  "access-logs-{sha1(format("%s-%s", data.aws\_caller\_identity.current.account\_id, data.aws\_region.current.region))}" | `string` | `""` | no |
| <a name="input_s3_access_logs_bucket_object_ownership"></a> [s3\_access\_logs\_bucket\_object\_ownership](#input\_s3\_access\_logs\_bucket\_object\_ownership) | The type of object ownership for the S3 access logs bucket. | `string` | `"BucketOwnerEnforced"` | no |
| <a name="input_s3_access_logs_bucket_policy_attachment"></a> [s3\_access\_logs\_bucket\_policy\_attachment](#input\_s3\_access\_logs\_bucket\_policy\_attachment) | The policy to apply to the logs bucket. | `any` | `null` | no |
| <a name="input_s3_access_logs_bucket_replication_configuration"></a> [s3\_access\_logs\_bucket\_replication\_configuration](#input\_s3\_access\_logs\_bucket\_replication\_configuration) | Replication configuration for the S3 bucket. | `any` | `{}` | no |
| <a name="input_s3_access_logs_bucket_server_side_encryption_algorithm"></a> [s3\_access\_logs\_bucket\_server\_side\_encryption\_algorithm](#input\_s3\_access\_logs\_bucket\_server\_side\_encryption\_algorithm) | The server-side encryption algorithm to use for the S3 bucket. | `any` | <pre>{<br/>  "rule": {<br/>    "apply_server_side_encryption_by_default": {<br/>      "sse_algorithm": "AES256"<br/>    }<br/>  }<br/>}</pre> | no |
| <a name="input_s3_access_logs_bucket_tags"></a> [s3\_access\_logs\_bucket\_tags](#input\_s3\_access\_logs\_bucket\_tags) | Tags to be applied to the S3 access logs bucket. | `map(string)` | `{}` | no |
| <a name="input_s3_access_logs_bucket_versioning"></a> [s3\_access\_logs\_bucket\_versioning](#input\_s3\_access\_logs\_bucket\_versioning) | Enable versioning for the S3 bucket. | `any` | <pre>{<br/>  "enabled": true<br/>}</pre> | no |
| <a name="input_s3_tf_state_bucket_allowed_kms_key_arn"></a> [s3\_tf\_state\_bucket\_allowed\_kms\_key\_arn](#input\_s3\_tf\_state\_bucket\_allowed\_kms\_key\_arn) | The ARN of KMS key which should be allowed in PutObject | `string` | `null` | no |
| <a name="input_s3_tf_state_bucket_attach_deny_incorrect_kms_key_sse"></a> [s3\_tf\_state\_bucket\_attach\_deny\_incorrect\_kms\_key\_sse](#input\_s3\_tf\_state\_bucket\_attach\_deny\_incorrect\_kms\_key\_sse) | Controls if S3 bucket policy should deny usage of incorrect KMS key SSE. | `bool` | `false` | no |
| <a name="input_s3_tf_state_bucket_logging"></a> [s3\_tf\_state\_bucket\_logging](#input\_s3\_tf\_state\_bucket\_logging) | Logging settings for the S3 bucket. By default, module will use acess logs bucket. | `map(string)` | `{}` | no |
| <a name="input_s3_tf_state_bucket_name"></a> [s3\_tf\_state\_bucket\_name](#input\_s3\_tf\_state\_bucket\_name) | The name of the S3 bucket.<br/>  If not specified, the module will generate a name automatically like:<br/>  "terraform-state-{sha1(format("%s-%s", data.aws\_caller\_identity.current.account\_id, data.aws\_region.current.name))}" | `string` | `""` | no |
| <a name="input_s3_tf_state_bucket_server_side_encryption_configuration"></a> [s3\_tf\_state\_bucket\_server\_side\_encryption\_configuration](#input\_s3\_tf\_state\_bucket\_server\_side\_encryption\_configuration) | The server-side encryption algorithm to use for the S3 bucket. | `any` | <pre>{<br/>  "rule": {<br/>    "apply_server_side_encryption_by_default": {<br/>      "sse_algorithm": "AES256"<br/>    }<br/>  }<br/>}</pre> | no |
| <a name="input_s3_tf_state_bucket_tags"></a> [s3\_tf\_state\_bucket\_tags](#input\_s3\_tf\_state\_bucket\_tags) | Tags to be applied to the S3 bucket. | `map(string)` | `{}` | no |
| <a name="input_s3_tf_state_bucket_versioning"></a> [s3\_tf\_state\_bucket\_versioning](#input\_s3\_tf\_state\_bucket\_versioning) | Enable versioning for the S3 bucket. | `any` | <pre>{<br/>  "enabled": true<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_logs_bucket_arn"></a> [access\_logs\_bucket\_arn](#output\_access\_logs\_bucket\_arn) | The ARN of the S3 bucket used for storing Terraform state |
| <a name="output_access_logs_bucket_name"></a> [access\_logs\_bucket\_name](#output\_access\_logs\_bucket\_name) | The name of the S3 bucket used for storing access logs |
| <a name="output_state_bucket_arn"></a> [state\_bucket\_arn](#output\_state\_bucket\_arn) | The ARN of the S3 bucket used for storing Terraform state |
| <a name="output_state_bucket_name"></a> [state\_bucket\_name](#output\_state\_bucket\_name) | The ARN of the S3 bucket used for storing Terraform state |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
