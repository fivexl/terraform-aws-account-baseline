# S3 Baseline Module


This Terraform module is a comprehensive solution for configuring Amazon S3 (Simple Storage Service) buckets in your AWS environment. It's crafted to ensure a secure, efficient, and standardized setup, aligning with AWS best practices and organizational policies.

## Usage

To use this module, include the following code in your Terraform configuration:

```hcl
module "terraform_state_bucket" {
  source = "../s3_baseline"

  logging     = local.state_logging_configuration
  bucket_name = local.state_bucket_name

  tags = merge(var.s3_tf_state_bucket_tags, var.tags)
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.27.0, < 6.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket_baseline"></a> [bucket\_baseline](#module\_bucket\_baseline) | terraform-aws-modules/s3-bucket/aws | 4.0.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_kms_key_arn"></a> [allowed\_kms\_key\_arn](#input\_allowed\_kms\_key\_arn) | The ARN of KMS key which should be allowed in PutObject | `string` | `null` | no |
| <a name="input_attach_deny_incorrect_kms_key_sse"></a> [attach\_deny\_incorrect\_kms\_key\_sse](#input\_attach\_deny\_incorrect\_kms\_key\_sse) | Controls if S3 bucket policy should deny usage of incorrect KMS key SSE. | `bool` | `false` | no |
| <a name="input_attach_log_delivery_policies"></a> [attach\_log\_delivery\_policies](#input\_attach\_log\_delivery\_policies) | Attach S3/VPC/NLB/ALB/ELB access log delivery policy to the bucket. | `bool` | `false` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the bucket. | `string` | n/a | yes |
| <a name="input_control_object_ownership"></a> [control\_object\_ownership](#input\_control\_object\_ownership) | Control object ownership for the bucket. | `bool` | `true` | no |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | If true, module will create S3 bucket, with predefined best practices. | `bool` | `true` | no |
| <a name="input_is_logging_bucket"></a> [is\_logging\_bucket](#input\_is\_logging\_bucket) | If this bucket is a logging bucket, we may not need to enable logging, to not end up with access logs delivered to themselves. | `bool` | `false` | no |
| <a name="input_lifecycle_rule"></a> [lifecycle\_rule](#input\_lifecycle\_rule) | List of maps containing configuration of object lifecycle management. | `any` | `[]` | no |
| <a name="input_logging"></a> [logging](#input\_logging) | Map containing access bucket logging configuration. | `map(string)` | n/a | yes |
| <a name="input_object_ownership"></a> [object\_ownership](#input\_object\_ownership) | The type of object ownership for the bucket. | `string` | `"BucketOwnerEnforced"` | no |
| <a name="input_replication_configuration"></a> [replication\_configuration](#input\_replication\_configuration) | Replication configuration for the S3 bucket. | `any` | `{}` | no |
| <a name="input_server_side_encryption_configuration"></a> [server\_side\_encryption\_configuration](#input\_server\_side\_encryption\_configuration) | The server-side encryption algorithm to use for the S3 bucket. | `any` | <pre>{<br>  "rule": {<br>    "apply_server_side_encryption_by_default": {<br>      "sse_algorithm": "AES256"<br>    }<br>  }<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to the bucket. | `map(string)` | `{}` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Enable versioning for the S3 bucket. | `any` | <pre>{<br>  "enabled": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The ARN of the S3 bucket used for storing Terraform state |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | The ARN of the S3 bucket used for storing Terraform state |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
