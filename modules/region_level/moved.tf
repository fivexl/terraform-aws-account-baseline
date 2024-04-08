# move to s3 baseline bucket
moved {
  from = module.access_logs_bucket[0]
  to   = module.logs_bucket.module.bucket_baseline[0]
}

moved {
  from = module.access_logs_bucket.module.bucket_baseline[0]
  to   = module.access_logs_bucket[0]
}

#Refactor dynamodb state lock to use dynamodb module
moved {
  from = module.dynanodb_tf_state_lock_[0].aws_dynamodb_table.this[0]
  to   = module.dynanodb_tf_state_lock[0].aws_dynamodb_table.this[0]
}

moved {
  from = module.dynanodb_tf_state_lock[0].aws_dynamodb_table.this[0]
  to   = module.dynamodb_tf_state_lock[0].aws_dynamodb_table.this[0]
}
