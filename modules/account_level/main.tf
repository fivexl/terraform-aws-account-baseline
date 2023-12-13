resource "aws_iam_account_alias" "alias" { 
  count = var.aws_iam_account_alias != "" ? 1 : 0
  account_alias = var.aws_iam_account_alias
}

resource "aws_iam_account_password_policy" "default" { 
  count = var.create_iam_account_password_policy ? 1 : 0
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

# test:
data "tls_certificate" "github_actions_oidc_provider" {
  # Read https://github.blog/changelog/2022-01-13-github-actions-update-on-oidc-based-deployments-to-aws/
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

resource "aws_iam_openid_connect_provider" "github" {
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider
  # Read https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
  # Read https://github.com/aws-actions/configure-aws-credentials
  # Read https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html
  # https://github.blog/changelog/2022-01-13-github-actions-update-on-oidc-based-deployments-to-aws/
  # https://github.blog/changelog/2023-06-27-github-actions-update-on-oidc-integration-with-aws/
  url            = "https://token.actions.githubusercontent.com" # The secure OpenID Connect URL for authentication requests
  client_id_list = ["sts.amazonaws.com"]                # The client ID issued by the Identity provider for your app
  # Same as pressing the «Get thumbprint» button next to provider URL in the GUI
  thumbprint_list = distinct(concat(
    [data.tls_certificate.github_actions_oidc_provider.certificates[0].sha1_fingerprint],
  ))
}