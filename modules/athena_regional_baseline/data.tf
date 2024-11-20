data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "naming_conventions" {
  source  = "fivexl/naming-conventions/aws"
  version = "0.0.1"
}
