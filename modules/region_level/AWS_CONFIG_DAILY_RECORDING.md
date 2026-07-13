# AWS Config Daily Recording

## Overview

AWS Control Tower enables AWS Config with **CONTINUOUS** recording by default on all enrolled accounts. This records every configuration change as it happens, which provides real-time visibility but can generate significant costs at scale.

This module allows you to switch the recording mode to **DAILY**, where Config captures a snapshot of your resource configurations once every 24 hours instead of on every change. This reduces AWS Config costs while still maintaining compliance visibility for most use cases.

## Usage
in the aft-account-customizations repo , in the modules/region/baseline.tf path add the following variable 
```hcl
module "baseline" {
  source = "fivexl/account-baseline/aws//modules/region_level"

  manage_aws_config_recording_mode = true
}
```

That's it. The module will:

1. Look up the existing IAM role (`aws-controltower-ConfigRecorderRole`) created by Control Tower
2. Update the recording mode from `CONTINUOUS` to `DAILY`

**Note:** You must import the existing recorder into state on first use. See the "Importing the Existing Recorder" section below.

## Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `manage_aws_config_recording_mode` | `false` | Set to `true` to manage the recording mode |
| `aws_config_recording_frequency` | `"DAILY"` | Recording frequency: `CONTINUOUS` or `DAILY` |
| `aws_config_recorder_name` | `"default"` | Name of the existing recorder |
| `aws_config_recorder_role_arn` | `""` | Override the role ARN (auto-detected if empty) |
| `aws_config_recorder_role_name` | `"aws-controltower-ConfigRecorderRole"` | Role name for auto-detection |
| `aws_config_recording_group` | `{ all_supported = true, include_global_resource_types = false }` | Recording group settings |

## How It Works

- **Role detection**: Looks up the Control Tower-created IAM role by name via a `data "aws_iam_role"` data source. You can skip this by providing `aws_config_recorder_role_arn` directly.
- **Idempotent**: If you deploy this to an account where Config is already set to DAILY, Terraform will show no changes.

## Importing the Existing Recorder

Since AWS Config is already running in your accounts, you need to import the existing recorder into Terraform state. Do this from the **root module** (your AFT customizations), not inside this module.

**Option A** - Import block in your root module (Terraform >= 1.5):

```hcl
import {
  to = module.baseline.aws_config_configuration_recorder.this[0]
  id = "default"
}
```

**Option B** - CLI import:

```bash
terraform import 'module.baseline.aws_config_configuration_recorder.this[0]' default
```

After the first successful apply, you can remove the import block — the resource will already be in state.

## Important Notes

- **Control Tower compatibility**: This only modifies the recording frequency. It does not touch the delivery channel, IAM role permissions, or recorder status (enabled/disabled). Control Tower continues to manage those.
- **Multi-region**: You need to enable this in each region module instance. In a typical AFT setup where you call the region_level module for each region, add `manage_aws_config_recording_mode = true` to each call.
- **Reverting**: Set `aws_config_recording_frequency = "CONTINUOUS"` to switch back without removing the resource from state.

## Cost Impact

DAILY recording can significantly reduce AWS Config costs for accounts with high rates of configuration changes. The exact savings depend on your workload, but accounts with frequent autoscaling, CI/CD deployments, or short-lived resources benefit the most.

Note that DAILY recording means configuration drift or unauthorized changes won't be recorded until the next daily snapshot. If real-time detection is critical for specific resource types, consider keeping those on CONTINUOUS using Config's recording mode overrides (not currently exposed by this module but can be added).
