# ------------------------------------------------------------------------------------------------------------------
# AWS Config - Recording Mode Configuration
# ------------------------------------------------------------------------------------------------------------------
# AWS Config is typically already enabled by Control Tower / AWS Organizations with CONTINUOUS
# recording. This resource manages the existing configuration recorder to switch
# it to DAILY recording, which reduces costs while still maintaining compliance visibility.
#
# Prerequisites:
# - AWS Config must already be enabled (e.g., by Control Tower)
# - The existing recorder must be imported into state from the root module:
#   terraform import 'module.<name>.aws_config_configuration_recorder.this[0]' default
# ------------------------------------------------------------------------------------------------------------------

data "aws_iam_role" "config_recorder" {
  count = var.manage_aws_config_recording_mode && var.aws_config_recorder_role_arn == "" ? 1 : 0

  name = var.aws_config_recorder_role_name
}

locals {
  aws_config_role_arn = var.aws_config_recorder_role_arn != "" ? var.aws_config_recorder_role_arn : try(data.aws_iam_role.config_recorder[0].arn, "")
}

resource "aws_config_configuration_recorder" "this" {
  count = var.manage_aws_config_recording_mode ? 1 : 0

  name     = var.aws_config_recorder_name
  role_arn = local.aws_config_role_arn

  recording_group {
    all_supported                 = var.aws_config_recording_group.all_supported
    include_global_resource_types = var.aws_config_recording_group.include_global_resource_types
  }

  recording_mode {
    recording_frequency = var.aws_config_recording_frequency
  }
}
