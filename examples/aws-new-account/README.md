# AWS New Account Example

This example demonstrates how to create F5 Distributed Cloud (XC) AWS Cloud Credentials with automatically created AWS IAM resources. The module will create:

- AWS IAM User with programmatic access
- AWS Access Key and Secret Key
- Required AWS IAM Policies for Transit Gateway and DirectConnect operations
- F5 XC Cloud Credentials object

## Prerequisites

- Terraform >= 1.3
- Valid F5 XC API credentials (P12 certificate file)
- AWS credentials with permissions to create IAM users and policies
- Configure the required variables (see `var.tf`)

## Configuration

Update the variables in `var.tf` or create a `terraform.tfvars` file with your specific values:

```hcl
xc_api_url      = "https://your-tenant.console.ves.volterra.io/api"
xc_api_p12_file = "./path/to/your/api-certificate.p12"
aws_access_key  = "your-aws-access-key"
aws_secret_key  = "your-aws-secret-key"
```

## Usage

```hcl
module "aws_creds" {
  source  = "f5devcentral/aws-cloud-credentials/volterra" 
  
  name = "aws-tf-demo-creds"

  # Enable IAM policies for specific services
  create_aws_tgw_iam        = true
  create_direct_connect_iam = true
}
```

## Deployment

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Review the planned changes:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

## Outputs

This example outputs the following values:

| Name                               | Description                                 |
| ---------------------------------- | ------------------------------------------- |
| `access_key`                       | Created AWS Access Key ID                   |
| `secret_key`                       | Created AWS Secret Access Key (sensitive)   |
| `user`                             | Created AWS IAM user name                   |
| `aws_iam_vpc_site_policy_arn`      | ARN of the created VPC Site IAM policy      |
| `aws_iam_tgw_site_policy_arn`      | ARN of the created TGW Site IAM policy      |
| `aws_iam_directconnect_policy_arn` | ARN of the created DirectConnect IAM policy |
| `name`                             | F5 XC Cloud Credentials name                |
| `namespace`                        | F5 XC Cloud Credentials namespace           |
| `id`                               | F5 XC Cloud Credentials ID                  |

## Clean Up

To remove all created resources:

```bash
terraform destroy
```

**Note**: This will delete the AWS IAM user, access keys, policies, and the F5 XC Cloud Credentials. Make sure this is intended before proceeding.