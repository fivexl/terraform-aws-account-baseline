# Aws_account_baseline region level module

## Overview
The terraform-aws-regional-baseline module is a Terraform solution designed for setting up essential regional resources in AWS with a focus on security and best practices. This configuration helps in maintaining a secure and efficient AWS environment at the regional level.

## Included Resources
- aws_ebs_encryption_by_default: Automatically enables encryption for new EBS volumes and snapshots created in the region.
- terraform_state_bucket: Creates an S3 bucket designed to store Terraform state files securely.
- aws_dynamodb_table: Sets up a DynamoDB table, used for locking Terraform state files to prevent conflicts.
- access_logs_bucket: Establishes an S3 bucket for storing access logs, assisting in monitoring and auditing activities.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.27.0, < 6.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_access_logs_bucket"></a> [access\_logs\_bucket](#module\_access\_logs\_bucket) | terraform-aws-modules/s3-bucket/aws | 4.0.1 |
| <a name="module_dynamodb_tf_state_lock"></a> [dynamodb\_tf\_state\_lock](#module\_dynamodb\_tf\_state\_lock) | terraform-aws-modules/dynamodb-table/aws | 4.0.0 |
| <a name="module_terraform_state_bucket"></a> [terraform\_state\_bucket](#module\_terraform\_state\_bucket) | ../s3_baseline | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ebs_encryption_by_default.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_encryption_by_default) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_dynamodb_tf_state_lock"></a> [create\_dynamodb\_tf\_state\_lock](#input\_create\_dynamodb\_tf\_state\_lock) | If true, module will create DynamoDB table for storing Terraform state lock | `bool` | `true` | no |
| <a name="input_create_s3_access_logs_bucket"></a> [create\_s3\_access\_logs\_bucket](#input\_create\_s3\_access\_logs\_bucket) | If true, module will create S3 bucket for storing access logs | `bool` | `true` | no |
| <a name="input_create_s3_tf_state_bucket"></a> [create\_s3\_tf\_state\_bucket](#input\_create\_s3\_tf\_state\_bucket) | If true, module will create S3 bucket for storing Terraform state | `bool` | `true` | no |
| <a name="input_dynamodb_tf_state_lock_attribute"></a> [dynamodb\_tf\_state\_lock\_attribute](#input\_dynamodb\_tf\_state\_lock\_attribute) | The attributes for the DynamoDB table. | <pre>list(object({<br>    name = string<br>    type = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "LockID",<br>    "type": "S"<br>  }<br>]</pre> | no |
| <a name="input_dynamodb_tf_state_lock_billing_mode"></a> [dynamodb\_tf\_state\_lock\_billing\_mode](#input\_dynamodb\_tf\_state\_lock\_billing\_mode) | The billing mode for the DynamoDB table. | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_dynamodb_tf_state_lock_hash_key"></a> [dynamodb\_tf\_state\_lock\_hash\_key](#input\_dynamodb\_tf\_state\_lock\_hash\_key) | The hash key for the DynamoDB table. | `string` | `"LockID"` | no |
| <a name="input_dynamodb_tf_state_lock_name"></a> [dynamodb\_tf\_state\_lock\_name](#input\_dynamodb\_tf\_state\_lock\_name) | The name of the DynamoDB table.<br>  If not specified, the module will generate a name automatically like:<br>  "terraform-state-{sha1(format("%s-%s", data.aws\_caller\_identity.current.account\_id, data.aws\_region.current.name))}" | `string` | `""` | no |
| <a name="input_dynamodb_tf_state_lock_server_side_encryption_enabled"></a> [dynamodb\_tf\_state\_lock\_server\_side\_encryption\_enabled](#input\_dynamodb\_tf\_state\_lock\_server\_side\_encryption\_enabled) | Enable server-side encryption for the DynamoDB table. | `bool` | `true` | no |
| <a name="input_dynamodb_tf_state_lock_server_side_encryption_kms_key_arn"></a> [dynamodb\_tf\_state\_lock\_server\_side\_encryption\_kms\_key\_arn](#input\_dynamodb\_tf\_state\_lock\_server\_side\_encryption\_kms\_key\_arn) | The ARN of the CMK that should be used for the AWS KMS encryption. This attribute should only be specified if the key is different from the default DynamoDB CMK, alias/aws/dynamodb. | `string` | `null` | no |
| <a name="input_dynamodb_tf_state_lock_tags"></a> [dynamodb\_tf\_state\_lock\_tags](#input\_dynamodb\_tf\_state\_lock\_tags) | Tags for the DynamoDB table. | `map(string)` | `{}` | no |
| <a name="input_s3_access_logs_bucket_allowed_kms_key_arn"></a> [s3\_access\_logs\_bucket\_allowed\_kms\_key\_arn](#input\_s3\_access\_logs\_bucket\_allowed\_kms\_key\_arn) | The ARN of KMS key which should be allowed in PutObject | `string` | `null` | no |
| <a name="input_s3_access_logs_bucket_attach_deny_incorrect_kms_key_sse"></a> [s3\_access\_logs\_bucket\_attach\_deny\_incorrect\_kms\_key\_sse](#input\_s3\_access\_logs\_bucket\_attach\_deny\_incorrect\_kms\_key\_sse) | Controls if S3 bucket policy should deny usage of incorrect KMS key SSE. | `bool` | `false` | no |
| <a name="input_s3_access_logs_bucket_control_object_ownership"></a> [s3\_access\_logs\_bucket\_control\_object\_ownership](#input\_s3\_access\_logs\_bucket\_control\_object\_ownership) | Control object ownership for the S3 access logs bucket. | `bool` | `true` | no |
| <a name="input_s3_access_logs_bucket_lifecycle_rule"></a> [s3\_access\_logs\_bucket\_lifecycle\_rule](#input\_s3\_access\_logs\_bucket\_lifecycle\_rule) | List of maps containing configuration of object lifecycle management. | `any` | `[]` | no |
| <a name="input_s3_access_logs_bucket_name"></a> [s3\_access\_logs\_bucket\_name](#input\_s3\_access\_logs\_bucket\_name) | The name of the S3 bucket.<br>  If not specified, the module will generate a name automatically like:<br>  "access-logs-{sha1(format("%s-%s", data.aws\_caller\_identity.current.account\_id, data.aws\_region.current.name))}" | `string` | `""` | no |
| <a name="input_s3_access_logs_bucket_object_ownership"></a> [s3\_access\_logs\_bucket\_object\_ownership](#input\_s3\_access\_logs\_bucket\_object\_ownership) | The type of object ownership for the S3 access logs bucket. | `string` | `"BucketOwnerEnforced"` | no |
| <a name="input_s3_access_logs_bucket_replication_configuration"></a> [s3\_access\_logs\_bucket\_replication\_configuration](#input\_s3\_access\_logs\_bucket\_replication\_configuration) | Replication configuration for the S3 bucket. | `any` | `{}` | no |
| <a name="input_s3_access_logs_bucket_server_side_encryption_algorithm"></a> [s3\_access\_logs\_bucket\_server\_side\_encryption\_algorithm](#input\_s3\_access\_logs\_bucket\_server\_side\_encryption\_algorithm) | The server-side encryption algorithm to use for the S3 bucket. | `any` | <pre>{<br>  "rule": {<br>    "apply_server_side_encryption_by_default": {<br>      "sse_algorithm": "AES256"<br>    }<br>  }<br>}</pre> | no |
| <a name="input_s3_access_logs_bucket_tags"></a> [s3\_access\_logs\_bucket\_tags](#input\_s3\_access\_logs\_bucket\_tags) | Tags to be applied to the S3 access logs bucket. | `map(string)` | `{}` | no |
| <a name="input_s3_access_logs_bucket_versioning"></a> [s3\_access\_logs\_bucket\_versioning](#input\_s3\_access\_logs\_bucket\_versioning) | Enable versioning for the S3 bucket. | `any` | <pre>{<br>  "enabled": true<br>}</pre> | no |
| <a name="input_s3_tf_state_bucket_allowed_kms_key_arn"></a> [s3\_tf\_state\_bucket\_allowed\_kms\_key\_arn](#input\_s3\_tf\_state\_bucket\_allowed\_kms\_key\_arn) | The ARN of KMS key which should be allowed in PutObject | `string` | `null` | no |
| <a name="input_s3_tf_state_bucket_attach_deny_incorrect_kms_key_sse"></a> [s3\_tf\_state\_bucket\_attach\_deny\_incorrect\_kms\_key\_sse](#input\_s3\_tf\_state\_bucket\_attach\_deny\_incorrect\_kms\_key\_sse) | Controls if S3 bucket policy should deny usage of incorrect KMS key SSE. | `bool` | `false` | no |
| <a name="input_s3_tf_state_bucket_logging"></a> [s3\_tf\_state\_bucket\_logging](#input\_s3\_tf\_state\_bucket\_logging) | Logging settings for the S3 bucket. By default, module will use acess logs bucket. | `map(string)` | `{}` | no |
| <a name="input_s3_tf_state_bucket_name"></a> [s3\_tf\_state\_bucket\_name](#input\_s3\_tf\_state\_bucket\_name) | The name of the S3 bucket.<br>  If not specified, the module will generate a name automatically like:<br>  "terraform-state-{sha1(format("%s-%s", data.aws\_caller\_identity.current.account\_id, data.aws\_region.current.name))}" | `string` | `""` | no |
| <a name="input_s3_tf_state_bucket_server_side_encryption_configuration"></a> [s3\_tf\_state\_bucket\_server\_side\_encryption\_configuration](#input\_s3\_tf\_state\_bucket\_server\_side\_encryption\_configuration) | The server-side encryption algorithm to use for the S3 bucket. | `any` | <pre>{<br>  "rule": {<br>    "apply_server_side_encryption_by_default": {<br>      "sse_algorithm": "AES256"<br>    }<br>  }<br>}</pre> | no |
| <a name="input_s3_tf_state_bucket_tags"></a> [s3\_tf\_state\_bucket\_tags](#input\_s3\_tf\_state\_bucket\_tags) | Tags to be applied to the S3 bucket. | `map(string)` | `{}` | no |
| <a name="input_s3_tf_state_bucket_versioning"></a> [s3\_tf\_state\_bucket\_versioning](#input\_s3\_tf\_state\_bucket\_versioning) | Enable versioning for the S3 bucket. | `any` | <pre>{<br>  "enabled": true<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_logs_bucket_arn"></a> [access\_logs\_bucket\_arn](#output\_access\_logs\_bucket\_arn) | The ARN of the S3 bucket used for storing Terraform state |
| <a name="output_access_logs_bucket_name"></a> [access\_logs\_bucket\_name](#output\_access\_logs\_bucket\_name) | The name of the S3 bucket used for storing access logs |
| <a name="output_dynamodb_state_lock_arn"></a> [dynamodb\_state\_lock\_arn](#output\_dynamodb\_state\_lock\_arn) | The ARN of the DynamoDB table used for state locking |
| <a name="output_dynamodb_state_lock_name"></a> [dynamodb\_state\_lock\_name](#output\_dynamodb\_state\_lock\_name) | The ARN of the DynamoDB table used for state locking |
| <a name="output_state_bucket_arn"></a> [state\_bucket\_arn](#output\_state\_bucket\_arn) | The ARN of the S3 bucket used for storing Terraform state |
| <a name="output_state_bucket_name"></a> [state\_bucket\_name](#output\_state\_bucket\_name) | The ARN of the S3 bucket used for storing Terraform state |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
