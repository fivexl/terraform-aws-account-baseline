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
  source  = "terraform-aws-modules/iam/aws//modules/iam-oidc-provider"
  version = "6.8.2"

  create = var.create_iam_github_oidc_provider
  url    = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_security_token_service_preferences" "this" {
  count                         = var.enable_v2_sts_token_version ? 1 : 0
  global_endpoint_token_version = "v2Token"
}

data "aws_caller_identity" "current" {}

# Same trust policy iam-assumable-roles emitted: account root, MFA required,
# sts:AssumeRole and sts:TagSession. Passed as a document so iam-role does not add a Sid.
data "aws_iam_policy_document" "aws_support_assume" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    condition {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = ["86400"]
    }
  }
}

module "aws_support_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "6.8.2"

  name                 = "AWSSupportRole"
  use_name_prefix      = false
  path                 = "/"
  max_session_duration = 3600

  policies = {
    AWSSupportAccess = "arn:aws:iam::aws:policy/AWSSupportAccess"
  }

  override_trust_policy_documents = [data.aws_iam_policy_document.aws_support_assume.json]
}

