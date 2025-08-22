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
