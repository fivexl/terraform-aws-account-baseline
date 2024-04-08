resource "aws_iam_account_alias" "alias" {
  count         = var.aws_iam_account_alias != "" ? 1 : 0
  account_alias = var.aws_iam_account_alias
}

resource "aws_iam_account_password_policy" "default" {
  count                          = var.create_iam_account_password_policy ? 1 : 0
  minimum_password_length        = 64
  password_reuse_prevention      = 24
  max_password_age               = 90
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}

resource "aws_s3_account_public_access_block" "this" {
  count                   = var.create_s3_account_public_access_block ? 1 : 0
  block_public_acls       = var.s3_account_public_access_block_public_acls
  block_public_policy     = var.s3_account_public_access_block_public_policy
  ignore_public_acls      = var.s3_account_public_access_block_ignore_public_acls
  restrict_public_buckets = var.s3_account_public_access_block_restrict_public_buckets
}

module "iam_github_oidc_provider" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider"
  version = "5.34.0"
  create = var.create_iam_github_oidc_provider
}

resource "aws_iam_security_token_service_preferences" "this" {
  count                         = var.enable_v2_sts_token_version ? 1 : 0
  global_endpoint_token_version = "v2Token"
}
