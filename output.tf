output "bucket_name" {
  description = "Bucket name for our static website"  
  value = module.terrahouse_aws.bucket_name
}
output "s3_website_endpoint" {
  description = "Bucket name for our static website"  
  value = module.terrahouse_aws.website_endpoint
}  
output "cloudfront_url" {
  description = "The cloudfront distribution Domain Name"
  value = module.terrahouse_aws.cloudfront_url
}