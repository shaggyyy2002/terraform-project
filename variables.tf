variable "user_uuid" {
  description = "The UUID of the user"
  type        = string
}
variable "bucket_name" {
  description = "The name of the AWS S3 bucket."
  type        = string
}
variable "index_html_filepath" {
  description = "Local path to the index.html file"
  type        = string
}
variable "error_html_filepath" {
  description = "Local path to the index.html file"
  type        = string
}
variable "content_version" {
  type        = number
}
