moved {
  from = aws_ebs_snapshot_block_public_access.this
  to   = aws_ebs_snapshot_block_public_access.this[0]
}

moved {
  from = aws_ebs_encryption_by_default.this
  to   = aws_ebs_encryption_by_default.this[0]
}
