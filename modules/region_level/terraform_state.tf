module "terraform_state_bucket" {
  source = "../s3_baseline"
  count  = var.create_s3_tf_state_bucket ? 1 : 0

  logging     = local.state_logging_configuration
  bucket_name = local.state_bucket_name
  versioning  = var.s3_tf_state_bucket_versioning

  tags = merge(var.s3_tf_state_bucket_tags, var.tags)
}

#tfsec:ignore:aws-dynamodb-table-customer-key tfsec:ignore:aws-dynamodb-enable-recovery
resource "aws_dynamodb_table" "state_lock" {
  count        = var.create_dynanodb_tf_state_lock ? 1 : 0
  name         = var.dynamodb_tf_state_lock_name != "" ? var.dynamodb_tf_state_lock_name : local.dynamodb_tf_state_lock_name
  hash_key     = var.dynamodb_tf_state_lock_hash_key
  billing_mode = var.dynamodb_tf_state_lock_billing_mode

  dynamic "attribute" {
    for_each = var.dynamodb_tf_state_lock_attribute
    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }
  }
  server_side_encryption {
    enabled = var.dynamodb_tf_state_lock_server_side_encryption_enabled
  }

  tags = merge(var.dynamodb_tf_state_lock_tags, var.tags)
}