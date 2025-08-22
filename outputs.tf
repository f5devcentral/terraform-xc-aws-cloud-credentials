# AWS Credentials
output "aws_access_key" {
  value       = local.access_key
  sensitive   = true
  description = "AWS Access Key"
}

output "aws_secret_key" {
  value       = local.secret_key
  sensitive   = true
  description = "AWS Secret Key"
}

# IAM User Information
output "aws_iam_user_name" {
  value       = try(aws_iam_user.this[0].name, null)
  sensitive   = true
  description = "Created AWS IAM User name"
}

output "aws_iam_user_arn" {
  value       = try(aws_iam_user.this[0].arn, null)
  sensitive   = true
  description = "The ARN assigned by AWS for the created IAM User"
}

output "aws_iam_user_id" {
  value       = try(aws_iam_user.this[0].unique_id, null)
  sensitive   = true
  description = "The unique ID assigned by AWS for the created IAM User"
}

# IAM Policy Information
output "aws_iam_vpc_site_policy_arn" {
  value       = try(aws_iam_policy.vpc_site[0].arn, null)
  description = "ARN of the created AWS IAM VPC Site Policy"
}

output "aws_iam_tgw_site_policy_arn" {
  value       = try(aws_iam_policy.tgw_site[0].arn, null)
  description = "ARN of the created AWS IAM TGW Site Policy"
}

output "aws_iam_directconnect_policy_arn" {
  value       = try(aws_iam_policy.directconnect[0].arn, null)
  description = "ARN of the created AWS IAM DirectConnect Policy"
}

output "aws_iam_vpc_site_policy_name" {
  value       = try(aws_iam_policy.vpc_site[0].name, null)
  description = "Name of the created AWS IAM VPC Site Policy"
}

output "aws_iam_tgw_site_policy_name" {
  value       = try(aws_iam_policy.tgw_site[0].name, null)
  description = "Name of the created AWS IAM TGW Site Policy"
}

output "aws_iam_directconnect_policy_name" {
  value       = try(aws_iam_policy.directconnect[0].name, null)
  description = "Name of the created AWS IAM DirectConnect Policy"
}

# F5 XC Cloud Credentials Information
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
