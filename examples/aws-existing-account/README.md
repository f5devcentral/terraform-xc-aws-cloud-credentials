# AWS Existing Account

The following example will create an F5 XC Cloud Credentials object without provisioning any resources in the AWS Cloud

```hcl
module "aws_creds" {
  source  = "f5devcentral/aws-cloud-credentials/volterra"
  version = "0.0.3"

  name = "aws-tf-demo-creds"
  aws_access_key = "your_existing_aws_access_key"
  aws_secret_key = "your_existing_aws_secret_key"
```