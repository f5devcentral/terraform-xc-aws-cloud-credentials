provider "volterra" {
  api_p12_file = var.xc_api_p12_file
  url          = var.xc_api_url
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-east-1"
}

module "aws_creds" {
  source = "../.."

  name           = "aws-example"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
}
