# 1.5.0 release removes `moved` blocks from the Terraform configuration of the region-level module. 

Previously, these `moved` blocks were used to simplify module usage by automatically relocating resources without requiring any action from the user. However, we have encountered drawbacks when using `moved` blocks inside a module. If a resource is moved within the module, it becomes impossible to move that resource later in the root configuration. Therefore, it was decided to remove these `moved` blocks.

- **If you are using version 1.2.0 or higher**, no action is required.  
- **If you are using versions prior to 1.2.0**, please update to version 1.2.0 first and then to the latest version to avoid any errors.  

Alternatively, you can manually add `moved` blocks to your root configuration, enabling you to update directly to version 1.4.4. Example:
```
# move to s3 baseline bucket
moved {
  from = module.<name_of_root_module>.module.access_logs_bucket[0]
  to   = module.<name_of_root_module>.module.logs_bucket.module.bucket_baseline[0]
}

moved {
  from = module.<name_of_root_module>.module.access_logs_bucket.module.bucket_baseline[0]
  to   = module.<name_of_root_module>.module.access_logs_bucket[0]
}

#Refactor dynamodb state lock to use dynamodb module
moved {
  from = module.<name_of_root_module>.module.dynanodb_tf_state_lock_[0].aws_dynamodb_table.this[0]
  to   = module.<name_of_root_module>.module.dynanodb_tf_state_lock[0].aws_dynamodb_table.this[0]
}

moved {
  from = module.<name_of_root_module>.module.dynanodb_tf_state_lock[0].aws_dynamodb_table.this[0]
  to   = module.<name_of_root_module>.module.dynamodb_tf_state_lock[0].aws_dynamodb_table.this[0]
}
```
