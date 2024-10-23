
# Terraform AWS Athena regional baseline module

This module sets up a baseline configuration for AWS Athena in your account. It follows best practices for security and reliability.

### Features:

- Sets up necessary resources for Athena with sensible defaults:
    - athena_query_results_bucket
    - aws_athena_workgroup
    - aws_glue_catalog_database
    - s3_access_logs_glue_table

### Usage:
This module is intended to be used as a part of the "account_baseline" module. 

AWS has default workgroup - "primary".
Terraform have 'aws_athena_workgroup', but to use it, we need to import it first.


```json
{
    "Query result location": "s3://athena-query-results-${env_id}/ ",
    "Encrypt query results": "SSE_S3",
    "Expected bucket owner": "${data.aws_caller_identity.current.account_id}",
    "Assign bucket owner": "full control over query results: Turned on",
}
```

#### Sample query
```sql
SELECT * 
FROM "s3_access_logs"."s3_server_access_logs_eu_central_1"
WHERE
    accountid = '222222222222'
    and bucket = 'terraform-state-$$$$$$$$$$$$$$'
    and region = 'eu-central-1'
limit 10
```

### Examples:

```hcl
module "athena_account_baseline_primary" {
  source = "fivexl/account-baseline/aws//modules/athena_account_baseline"

  create_athena_workgroup    = true
  s3_access_logs_bucket_name = module.account_baseline_region_level_primary.access_logs_bucket_name
  s3_access_logs_glue_table = {
    location = "s3://${module.account_baseline_region_level_primary.access_logs_bucket_name}"
  }
  s3_access_logs_glue_database = {
    create = true
  }
  query_results_bucket_lifecycle_rule = local.query_results_bucket_lifecycle_rule

  tags      = tags
  providers = { aws = aws.primary }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.27.0, < 6.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.27.0, < 6.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_athena_query_results_bucket"></a> [athena\_query\_results\_bucket](#module\_athena\_query\_results\_bucket) | fivexl/account-baseline/aws//modules/s3_baseline | 1.2.2 |
| <a name="module_naming_conventions"></a> [naming\_conventions](#module\_naming\_conventions) | ../naming_conventions | n/a |
| <a name="module_s3_access_logs_glue_table"></a> [s3\_access\_logs\_glue\_table](#module\_s3\_access\_logs\_glue\_table) | fivexl/s3-access-logs-athena-table/aws | 1.0.2 |

## Resources

| Name | Type |
|------|------|
| [aws_athena_workgroup.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_workgroup) | resource |
| [aws_glue_catalog_database.s3_access_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_athena_workgroup"></a> [create\_athena\_workgroup](#input\_create\_athena\_workgroup) | Whether to create an Athena workgroup | `bool` | `true` | no |
| <a name="input_query_results_bucket_lifecycle_rule"></a> [query\_results\_bucket\_lifecycle\_rule](#input\_query\_results\_bucket\_lifecycle\_rule) | The lifecycle rule for the query results bucket | `any` | `{}` | no |
| <a name="input_s3_access_logs_bucket_name"></a> [s3\_access\_logs\_bucket\_name](#input\_s3\_access\_logs\_bucket\_name) | The name of the S3 bucket for storing access logs | `string` | n/a | yes |
| <a name="input_s3_access_logs_glue_database"></a> [s3\_access\_logs\_glue\_database](#input\_s3\_access\_logs\_glue\_database) | Configuration for the Glue database for the S3 access logs | <pre>object({<br>    create = optional(bool, true)<br>    name   = optional(string, "s3_access_logs")<br>  })</pre> | <pre>{<br>  "create": true,<br>  "name": "s3_access_logs"<br>}</pre> | no |
| <a name="input_s3_access_logs_glue_table"></a> [s3\_access\_logs\_glue\_table](#input\_s3\_access\_logs\_glue\_table) | Configuration for the Glue table for the S3 access logs | <pre>object({<br>    name          = optional(string)<br>    database_name = optional(string)<br>    location      = string<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Key-value map of resource tags | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->