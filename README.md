# AWS Cloud Credentials for F5 Distributed Cloud (XC) Terraform Module

This Terraform module creates and manages AWS Cloud Credentials in F5 Distributed Cloud (XC). The module can either create new AWS IAM resources (user, policies, access keys) or use existing AWS credentials to establish cloud credentials in XC.

> **Note**: This module is developed and maintained by the [F5 DevCentral](https://github.com/f5devcentral) community. You can use this module as an example for your own development projects.

## Features

- **Flexible credential management**: Use existing AWS credentials or create new IAM user automatically
- **Configurable IAM permissions**: Optional policies for VPC sites, Transit Gateway, and Direct Connect
- **Secure credential handling**: Sensitive values are properly marked and handled
- **Input validation**: Ensures proper naming conventions and parameter validation
- **Comprehensive outputs**: Access to all created resources and their identifiers

## Requirements

| Name                                                                             | Version    |
| -------------------------------------------------------------------------------- | ---------- |
| [terraform](https://github.com/hashicorp/terraform)                              | >= 1.3     |
| [aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)         | >= 6.9.0   |
| [volterra](https://registry.terraform.io/providers/volterraedge/volterra/latest) | >= 0.11.44 |

## Usage

### Using Existing AWS Credentials

To use this module with your existing AWS credentials without creating new IAM resources:

```hcl
module "aws_cloud_credentials" {
  source = "f5devcentral/aws-cloud-credentials/volterra"

  name           = "my-aws-creds"
  aws_access_key = "AKIA..."
  aws_secret_key = "your_secret_key"

  tags = {
    Environment = "production"
    Project     = "xc-deployment"
  }
}
```

### Creating New IAM User and Credentials

To create a new AWS IAM user with the necessary permissions:

```hcl
module "aws_cloud_credentials" {
  source = "f5devcentral/aws-cloud-credentials/volterra"

  name = "xc-aws-auto-created"

  # Optional: Enable additional IAM permissions
  create_aws_tgw_iam         = true
  create_direct_connect_iam  = true

  tags = {
    Environment = "development"
    Project     = "xc-poc"
  }
}
```

### Advanced Configuration

```hcl
module "aws_cloud_credentials" {
  source = "f5devcentral/aws-cloud-credentials/volterra"

  name = "enterprise-xc-creds"
  
  # Enable all optional IAM policies
  create_aws_tgw_iam        = true
  create_direct_connect_iam = true

  # Custom tags for compliance and cost tracking
  tags = {
    Environment     = "production"
    Project         = "f5-xc-deployment"
    CostCenter      = "infrastructure"
    Owner           = "platform-team"
    Compliance      = "sox"
  }
}
```

## Inputs

| Name                      | Description                                                                     | Type          | Default                                  | Required |
| ------------------------- | ------------------------------------------------------------------------------- | ------------- | ---------------------------------------- | :------: |
| name                      | Cloud Credentials name.                                                         | `string`      | `"xc-aws"`                               |    no    |
| aws_access_key            | Existing AWS Access Key ID. If not provided, a new IAM user will be created     | `string`      | `null`                                   |    no    |
| aws_secret_key            | Existing AWS Secret Access Key. If not provided, a new IAM user will be created | `string`      | `null`                                   |    no    |
| create_aws_tgw_iam        | Create IAM permissions for AWS Transit Gateway operations                       | `bool`        | `false`                                  |    no    |
| create_direct_connect_iam | Create IAM permissions for AWS Direct Connect operations                        | `bool`        | `false`                                  |    no    |
| tags                      | A map of tags to add to all AWS resources                                       | `map(string)` | `{"Environment"="dev", "Name"="xc-aws"}` |    no    |

## Outputs

| Name                              | Description                                                                                    |
| --------------------------------- | ---------------------------------------------------------------------------------------------- |
| aws_access_key                    | AWS Access Key (sensitive)                                                                     |
| aws_secret_key                    | AWS Secret Key (sensitive)                                                                     |
| aws_iam_user_name                 | Created AWS IAM User name (sensitive)                                                          |
| aws_iam_user_arn                  | The ARN assigned by AWS for the created IAM User (sensitive)                                   |
| aws_iam_user_id                   | The unique ID assigned by AWS for the created IAM User (sensitive)                             |
| aws_iam_vpc_site_policy_arn       | ARN of the created AWS IAM VPC Site Policy                                                     |
| aws_iam_vpc_site_policy_name      | Name of the created AWS IAM VPC Site Policy                                                    |
| aws_iam_tgw_site_policy_arn       | ARN of the created AWS IAM TGW Site Policy (only if `create_aws_tgw_iam` is true)              |
| aws_iam_tgw_site_policy_name      | Name of the created AWS IAM TGW Site Policy (only if `create_aws_tgw_iam` is true)             |
| aws_iam_directconnect_policy_arn  | ARN of the created AWS IAM DirectConnect Policy (only if `create_direct_connect_iam` is true)  |
| aws_iam_directconnect_policy_name | Name of the created AWS IAM DirectConnect Policy (only if `create_direct_connect_iam` is true) |
| name                              | Created XC Cloud Credentials name                                                              |
| namespace                         | The namespace in which the XC Cloud Credentials is created                                     |
| id                                | ID of the XC Cloud Credentials                                                                 |

## IAM Permissions

When creating a new IAM user, this module creates the following policies:

### VPC Site Policy (Always Created)
Provides permissions for:
- EC2 instance management (create, describe, modify, terminate)
- VPC and networking operations (subnets, security groups, route tables)
- Auto Scaling Groups and Launch Templates
- Elastic Load Balancers
- IAM role management for EC2 instances

### Transit Gateway Policy (Optional - `create_aws_tgw_iam = true`)
Provides permissions for:
- Transit Gateway creation, modification, and deletion
- Transit Gateway attachments and route tables
- Cross-account TGW peering

### Direct Connect Policy (Optional - `create_direct_connect_iam = true`)
Provides permissions for:
- Direct Connect gateway management
- Virtual interfaces creation and management
- Direct Connect connection operations

## Examples

See the `examples/` directory for complete working examples:
- `examples/aws-existing-account/` - Using existing AWS credentials
- `examples/aws-new-account/` - Creating new IAM user and policies

## Security Considerations

- **Credential Storage**: When using existing credentials, ensure they are stored securely (e.g., using Terraform Cloud variables or AWS Secrets Manager)
- **Least Privilege**: Only enable the IAM policies you need (`create_aws_tgw_iam` and `create_direct_connect_iam`)
- **Sensitive Outputs**: Access keys and user information are marked as sensitive and won't appear in logs
- **Input Validation**: The module validates input parameters to prevent common configuration errors

## Troubleshooting

### Common Issues

1. **Validation Errors**: Ensure the `name` variable meets AWS IAM naming requirements (1-64 characters, alphanumeric and `+=,.@-` only)

2. **Permission Denied**: When using existing credentials, ensure they have sufficient permissions to create the XC Cloud Credentials

3. **Resource Already Exists**: If you see errors about existing resources, check for naming conflicts with existing IAM users or policies

## Contributing

Contributions to this module are welcome! Please see the contribution guidelines for more information.

## License

This module is licensed under the Apache 2.0 License.