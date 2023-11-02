# AWS New Account

The following example will create F5 XC Cloud Credentials, an AWS IAM User, an Access Key, a Secret Key, and the required AWS IAM Policies for AWS TGW Site deployment with DirectConnect.

```hcl
module "aws_creds" {
  source  = "f5devcentral/aws-cloud-credentials/volterra"
  version = "0.0.3"

  create_aws_tgw_iam        = true
  create_direct_connect_iam = true
}
```