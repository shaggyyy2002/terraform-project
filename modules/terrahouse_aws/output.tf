output "bucket_name" {
  value = aws_s3_bucket.website_bucket.bucket
}
output "website_endpoint" {
  description = "S3 staic website endpoint hosting"
  value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}