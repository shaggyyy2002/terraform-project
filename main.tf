terraform {
  cloud {
      organization = "terraform-bootcamp-nitin"
      workspaces {
        name = "terra-house-1"
    }
  }
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  # region     = "ap-south-1"
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"
}
provider "random" {
  # Configuration options
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  length           = 16
  lower = true
  upper = false
  special          = false
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "example" {

# Naming Rules: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket.html#aws-properties-s3-bucket--examples  
  bucket = random_string.bucket_name.result
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}

