variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Cloud Credentials name"
  type        = string
  default     = ""
}

variable "aws_access_key" {
  description = "Existing AWS Access Key ID"
  type        = string
  default     = null
}

variable "aws_secret_key" {
  description = "Existing AWS Secret Access Key"
  type        = string
  sensitive   = true
  default     = null
}

variable "create_direct_connect_iam" {
  description = "Create IAM permissions for Direct Connect"
  type        = bool
  default     = false
}

variable "create_aws_tgw_iam" {
  description = "Create IAM permissions for AWS TGW"
  type        = bool
  default     = false
}