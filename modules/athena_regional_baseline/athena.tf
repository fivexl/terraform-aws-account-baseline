module "athena_query_results_bucket" {
  source  = "fivexl/account-baseline/aws//modules/s3_baseline"
  version = "1.2.2"

  versioning  = { enabled = false }
  bucket_name = local.athena_query_results_bucket_name # This should be naming convention module
  logging = {
    target_bucket = var.s3_access_logs_bucket_name
  }
  lifecycle_rule = var.query_results_bucket_lifecycle_rule

  tags = var.tags
}

resource "aws_athena_workgroup" "primary" {
  count = var.create_athena_workgroup ? 1 : 0
  name  = "primary"

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = false
    bytes_scanned_cutoff_per_query     = 0 # no limit
    engine_version {
      selected_engine_version = "Athena engine version 3"
    }

    result_configuration {
      output_location       = "s3://${module.athena_query_results_bucket.s3_bucket_id}/"
      expected_bucket_owner = data.aws_caller_identity.current.account_id

      encryption_configuration {
        encryption_option = "SSE_S3"
      }
      acl_configuration {
        s3_acl_option = "BUCKET_OWNER_FULL_CONTROL"
      }
    }
  }

  tags = var.tags
}


resource "aws_glue_catalog_database" "s3_access_logs" {
  count = var.s3_access_logs_glue_database.create ? 1 : 0
  name  = var.s3_access_logs_glue_database.name

  create_table_default_permission {
    permissions = ["ALL"]

    principal {
      data_lake_principal_identifier = "IAM_ALLOWED_PRINCIPALS"
    }
  }
}

module "s3_access_logs_glue_table" {
  count   = var.s3_access_logs_glue_database.create ? 1 : 0
  source  = "fivexl/s3-access-logs-athena-table/aws"
  version = "1.0.2"

  name          = local.s3_access_logs_glue_table_name
  database_name = var.s3_access_logs_glue_database.create ? aws_glue_catalog_database.s3_access_logs[0].name : var.s3_access_logs_glue_database.name
  location      = var.s3_access_logs_glue_table.location
}
