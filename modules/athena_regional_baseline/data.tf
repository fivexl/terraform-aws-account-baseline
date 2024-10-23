data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "naming_convetions" {
  source  = "fivexl/naming-convetions/aws"
  version = "0.0.1"
}
