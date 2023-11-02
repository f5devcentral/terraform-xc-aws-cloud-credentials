# AWS Cloud Credentials for F5 Distributed Cloud (XC) Terraform module

This Terraform module provisions AWS Cloud Credentials in F5 Distributed Cloud (XC). It creates an IAM User, IAM Policy, Access Key, and Access Secret in AWS Cloud, along with a Cloud Credentials object in XC Cloud.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](https://github.com/hashicorp/terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) | >= 5.0 |
| <a name="requirement_volterra"></a> [volterra](https://registry.terraform.io/providers/volterraedge/volterra/latest) | >= 0.11.26 |

## Usage


To use this module and leverage your existing credentials without provisioning any resources on AWS Cloud, include the following code in your Terraform configuration:

```hcl
module "aws_cloud_credentials" {
  source = "f5devcentral/aws-cloud-credentials/volterra"

  name = "aws-tf-demo-creds"
  aws_access_key = "your_aws_access_key"
  aws_secret_key = "your_aws_secret_key"
}
```


If you want to create a new AWS IAM User

```hcl
module "aws_cloud_credentials" {
  source = "f5devcentral/aws-cloud-credentials/volterra"

  name = "aws-tf-demo-creds"
}
``````


## Contributing

Contributions to this module are welcome! Please see the contribution guidelines for more information.

## License

This module is licensed under the Apache 2.0 License.