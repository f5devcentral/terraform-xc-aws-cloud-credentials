# AWS Existing Account Example

This example demonstrates how to create F5 Distributed Cloud (XC) AWS Cloud Credentials using your existing AWS access credentials. This approach does not create any new AWS IAM resources - it simply registers your existing AWS credentials with F5 XC.

## Use Case

This example is ideal when you:

- Already have AWS IAM user credentials with the necessary permissions
- Want to manage AWS IAM resources separately from the XC Cloud Credentials
- Need to use existing credentials that are managed by your organization's AWS account policies

## Prerequisites

- Terraform >= 1.3
- Valid F5 XC API credentials (P12 certificate file)
- Existing AWS Access Key and Secret Key with appropriate permissions for your use case
- Configure the required variables (see `var.tf`)

## Configuration

Update the variables in `var.tf` or create a `terraform.tfvars` file with your specific values:

```hcl
xc_api_url      = "https://your-tenant.console.ves.volterra.io/api"
xc_api_p12_file = "./path/to/your/api-certificate.p12"
aws_access_key  = "AKIA..."
aws_secret_key  = "your-aws-secret-key"
```

## Usage

```hcl
module "aws_creds" {
  source = "../.."

  name           = "aws-tf-demo-creds"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
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

| Name         | Description                                |
| ------------ | ------------------------------------------ |
| `access_key` | The AWS Access Key ID used                 |
| `secret_key` | The AWS Secret Access Key used (sensitive) |
| `name`       | F5 XC Cloud Credentials name               |
| `namespace`  | F5 XC Cloud Credentials namespace          |
| `id`         | F5 XC Cloud Credentials ID                 |

## Important Notes

- **No AWS Resources Created**: This example only creates the F5 XC Cloud Credentials object. No AWS IAM users, policies, or access keys are created.
- **Existing Credentials**: Ensure your existing AWS credentials have the necessary permissions for the F5 XC operations you plan to perform.
- **Security**: Store your AWS credentials securely and follow your organization's credential management policies.

## Clean Up

To remove the F5 XC Cloud Credentials:

```bash
terraform destroy
```

**Note**: This will only delete the F5 XC Cloud Credentials object. Your existing AWS IAM resources remain unchanged.