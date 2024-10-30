resource "aws_ebs_snapshot_block_public_access" "this" {
  state = "block-all-sharing"
}

resource "aws_ebs_encryption_by_default" "this" {
  enabled = true
}