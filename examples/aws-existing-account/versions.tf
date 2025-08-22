terraform {
  required_version = ">= 1.0"

  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = ">=0.11.44"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">=6.9.0"
    }
  }
}
