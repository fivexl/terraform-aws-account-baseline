data "aws_caller_identity" "current" {}

module "naming_conventions" {
  source  = "fivexl/naming-conventions/aws"
  version = "0.1.1"
}
