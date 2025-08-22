output "access_key" {
  description = "AWS Access Key"
  sensitive   = true
  value       = module.aws_creds.aws_access_key
}

output "secret_key" {
  description = "AWS Secret Key"
  sensitive   = true
  value       = module.aws_creds.aws_secret_key
}

output "user" {
  description = "AWS IAM user name"
  sensitive   = true
  value       = module.aws_creds.aws_iam_user_name
}

output "aws_iam_vpc_site_policy_arn" {
  value       = module.aws_creds.aws_iam_vpc_site_policy_arn
  description = "Created AWS IAM VPC Site Policy arn"
}

output "aws_iam_tgw_site_policy_arn" {
  value       = module.aws_creds.aws_iam_tgw_site_policy_arn
  description = "Created AWS IAM TGW Site Policy arn"
}

output "aws_iam_directconnect_policy_arn" {
  value       = module.aws_creds.aws_iam_directconnect_policy_arn
  description = "Created AWS IAM DirectConnect Policy arn"
}

output "aws_iam_vpc_site_policy_name" {
  value       = module.aws_creds.aws_iam_vpc_site_policy_name
  description = "Created AWS IAM VPC Site Policy name"
}

output "aws_iam_tgw_site_policy_name" {
  value       = module.aws_creds.aws_iam_tgw_site_policy_name
  description = "Created AWS IAM TGW Site Policy name"
}

output "aws_iam_directconnect_policy_name" {
  value       = module.aws_creds.aws_iam_directconnect_policy_name
  description = "Created AWS IAM DirectConnect Policy name"
}

output "name" {
  description = "XC Cloud Credentials Name"
  value       = module.aws_creds.name
}

output "namespace" {
  description = "XC Cloud Credentials Namespace"
  value       = module.aws_creds.namespace
}

output "id" {
  description = "XC Cloud Credentials ID"
  value       = module.aws_creds.id
}
