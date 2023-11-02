output "aws_access_key" {
  value       = local.create_iam_user ? aws_iam_access_key.this[0].id : var.aws_access_key
  description = "AWS Access Key"
}

output "aws_secret_key" {
  value       = local.create_iam_user ? aws_iam_access_key.this[0].secret : var.aws_secret_key
  sensitive   = true
  description = "AWS Secret Key"
}

output "aws_iam_user_name" {
  value       = local.create_iam_user ? aws_iam_user.this[0].name : ""
  description = "Created AWS User name"
}

output "aws_iam_user_arn" {
  value       = local.create_iam_user ? aws_iam_user.this[0].arn : ""
  description = "The ARN assigned by AWS for the created IAM User"
}

output "aws_iam_user_id" {
  value       = local.create_iam_user ? aws_iam_user.this[0].unique_id : ""
  description = "The ID assigned by AWS for the created IAM User"
}

output "aws_iam_vpc_site_policy_arn" {
  value       = local.create_iam_user ? aws_iam_policy.vpc_site[0].arn : ""
  description = "Created AWS IAM VPC Site Policy arn"
}

output "aws_iam_tgw_site_policy_arn" {
  value       = local.create_iam_user && var.create_aws_tgw_iam ? aws_iam_policy.tgw_site[0].arn : ""
  description = "Created AWS IAM TGW Site Policy arn"
}

output "aws_iam_directconnect_policy_arn" {
  value       = local.create_iam_user && var.create_direct_connect_iam ? aws_iam_policy.directconnect[0].arn : ""
  description = "Created AWS IAM DirectConnect Policy arn"
}

output "aws_iam_vpc_site_policy_name" {
  value       = local.create_iam_user ? aws_iam_policy.vpc_site[0].name : ""
  description = "Created AWS IAM VPC Site Policy name"
}

output "aws_iam_tgw_site_policy_name" {
  value       = local.create_iam_user && var.create_aws_tgw_iam ? aws_iam_policy.tgw_site[0].name : ""
  description = "Created AWS IAM TGW Site Policy name"
}

output "aws_iam_directconnect_policy_name" {
  value       = local.create_iam_user && var.create_direct_connect_iam ? aws_iam_policy.directconnect[0].name : ""
  description = "Created AWS IAM DirectConnect Policy name"
}

output "name" {
  value       = volterra_cloud_credentials.this.name
  description = "Created XC Cloud Credentials name"
}

output "namespace" {
  value       = volterra_cloud_credentials.this.namespace
  description = "The namespace in which the XC Cloud Credentials is created"
}

output "id" {
  value       = volterra_cloud_credentials.this.id
  description = "ID of the XC Cloud Credentials"
}