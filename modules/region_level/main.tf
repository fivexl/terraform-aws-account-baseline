resource "aws_ebs_encryption_by_default" "this" {
  enabled = true
}

#tfsec:ignore:aws-s3-enable-bucket-logging
module "access_logs_bucket" {
  count   = var.create_s3_access_logs_bucket ? 1 : 0
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.15.1"

  bucket                               = local.access_logs_bucket_name
  versioning                           = var.s3_access_logs_bucket_versioning
  server_side_encryption_configuration = var.s3_access_logs_bucket_server_side_encryption_algorithm
  object_ownership                     = var.s3_access_logs_bucket_object_ownership
  control_object_ownership             = var.s3_access_logs_bucket_control_object_ownership
  attach_access_log_delivery_policy    = true
  block_public_acls                    = true
  block_public_policy                  = true
  ignore_public_acls                   = true
  restrict_public_buckets              = true
  tags                                 = merge(var.s3_access_logs_bucket_tags, var.tags)
}


