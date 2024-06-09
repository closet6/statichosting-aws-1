terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.53"
    }
  }


  # https://developer.hashicorp.com/terraform/language/settings/backends/s3
  # backend "s3" {
  #   bucket = ""
  #   key    = ""
  #   region = ""
  # }



  required_version = ">= 1.8.0"
}

provider "aws" {
  region = ""
}
