# AWS Config Daily Recording

## Overview

AWS Control Tower enables AWS Config with **CONTINUOUS** recording by default on all enrolled accounts. This records every configuration change as it happens, which provides real-time visibility but can generate significant costs at scale.

This module allows you to switch the recording mode to **DAILY**, where Config captures a snapshot of your resource configurations once every 24 hours instead of on every change. This reduces AWS Config costs while still maintaining compliance visibility for most use cases.

## Usage

In the aft-account-customizations repo, in the modules/region/baseline.tf path add the following variable:

```hcl
module "baseline" {
  source = "fivexl/account-baseline/aws//modules/region_level"

  manage_aws_config_recording_mode = true
}
```

And add an import block in the root module for each region:

```hcl
import {
  to = module.region_level_baseline_primary.module.baseline.aws_config_configuration_recorder.this[0]
  id = "default"
}

import {
  to = module.region_level_baseline_secondary.module.baseline.aws_config_configuration_recorder.this[0]
  id = "default"
}
```

The import block is safe to leave permanently — if the resource is already in state, Terraform skips it.

The module will:

1. Use the AWS Config service-linked role (`AWSServiceRoleForConfig`) automatically
2. Update the recording mode from `CONTINUOUS` to `DAILY`

## Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `manage_aws_config_recording_mode` | `false` | Set to `true` to manage the recording mode |
| `aws_config_recording_frequency` | `"DAILY"` | Recording frequency: `CONTINUOUS` or `DAILY` |
| `aws_config_recorder_name` | `"default"` | Name of the existing recorder |
| `aws_config_recorder_role_arn` | `""` | Override the role ARN. If empty, defaults to the service-linked role |
| `aws_config_recording_group` | `{ all_supported = true, include_global_resource_types = false }` | Recording group settings |

## How It Works

- **Role ARN**: Constructs the service-linked role ARN automatically from the account ID: `arn:aws:iam::<account_id>:role/aws-service-role/config.amazonaws.com/AWSServiceRoleForConfig`. You can override this with `aws_config_recorder_role_arn` if your setup uses a different role.
- **Idempotent**: If you deploy this to an account where Config is already set to DAILY, Terraform will show no changes.
- **Import**: The existing recorder must be imported into state from the root module (see Usage above). The import block is a no-op on subsequent runs.

## Important Notes

- **Control Tower compatibility**: This only modifies the recording frequency. It does not touch the delivery channel, IAM role permissions, or recorder status (enabled/disabled). Control Tower continues to manage those.
- **Multi-region**: You need to enable this in each region module instance. In a typical AFT setup where you call the region_level module for each region, add `manage_aws_config_recording_mode = true` to each call.
- **Reverting**: Set `aws_config_recording_frequency = "CONTINUOUS"` to switch back without removing the resource from state.

## Cost Impact

DAILY recording can significantly reduce AWS Config costs for accounts with high rates of configuration changes. The exact savings depend on your workload, but accounts with frequent autoscaling, CI/CD deployments, or short-lived resources benefit the most.

Note that DAILY recording means configuration drift or unauthorized changes won't be recorded until the next daily snapshot. If real-time detection is critical for specific resource types, consider keeping those on CONTINUOUS using Config's recording mode overrides (not currently exposed by this module but can be added).
