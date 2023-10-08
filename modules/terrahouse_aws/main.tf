terraform {
    required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}
# # https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
# resource "random_string" "bucket_name" {
#   lower = true
#   upper = false
#   length   = 32
#   special  = false
# }

data "aws_caller_identity" "current" {}

