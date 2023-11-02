variable "xc_api_url" {
  description = "XC Cloud API URL"
  type        = string
  default     = "https://your_xc-cloud_api_url.console.ves.volterra.io/api"
}

variable "xc_api_p12_file" {
  description = "Path to XC Cloud API certificate"
  type        = string
  default     = "./api-certificate.p12"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  default     = "your_aws_access_key"
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
  default     = "your_aws_secret_key"
}