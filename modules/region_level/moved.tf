moved {
  from = module.access_logs_bucket.module.bucket_baseline[0]
  to   = module.access_logs_bucket[0]
}

#Refactor dynamodb state lock to use dynamodb module
moved {
  from = aws_dynamodb_table.state_lock[0]
  to   = module.dynanodb_tf_state_lock_[0].aws_dynamodb_table.this[0]
}
