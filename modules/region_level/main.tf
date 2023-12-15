resource "aws_ebs_encryption_by_default" "this" {
  enabled = true
}

#tfsec:ignore:aws-s3-enable-bucket-logging
module "access_logs_bucket" {
  source = "../s3_baseline"

  bucket_name = local.access_logs_bucket_name
  create_bucket = var.create_s3_access_logs_bucket
  versioning = var.s3_access_logs_bucket_versioning
  server_side_encryption_configuration = var.s3_access_logs_bucket_server_side_encryption_algorithm
  object_ownership = var.s3_access_logs_bucket_object_ownership
  control_object_ownership = var.s3_access_logs_bucket_control_object_ownership
  attach_access_log_delivery_policy = true
  tags = merge(var.s3_access_logs_bucket_tags, var.tags)
}


