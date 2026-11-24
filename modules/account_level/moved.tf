# iam-assumable-roles (v5) addresses. iam-role (v6) uses different names.
moved {
  from = module.aws_support_role.aws_iam_role.poweruser[0]
  to   = module.aws_support_role.aws_iam_role.this[0]
}

moved {
  from = module.aws_support_role.aws_iam_role_policy_attachment.poweruser[0]
  to   = module.aws_support_role.aws_iam_role_policy_attachment.this["AWSSupportAccess"]
}
