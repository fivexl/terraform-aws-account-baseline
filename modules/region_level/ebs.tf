resource "aws_ebs_snapshot_block_public_access" "this" {
  count = var.create_ebs_snapshot_block_public_access ? 1 : 0
  state = "block-all-sharing"
}

resource "aws_ebs_encryption_by_default" "this" {
  count   = var.create_ebs_encryption_by_default ? 1 : 0
  enabled = true
}