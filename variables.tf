variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Name        = "xc-aws"
  }
}

variable "name" {
  description = "Cloud Credentials name"
  type        = string
  default     = "xc-aws"

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 64
    error_message = "Name must be between 1 and 64 characters."
  }
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
