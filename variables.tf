variable "user_uuid" {
  description = "The UUID of the user"
  type        = string
  validation {
    # This field specifies the validation condition using the regex function. 
    # It checks if the value of var.user_uuid matches the regular expression pattern for a UUID. 
    # The regular expression ^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$ 
    # represents the format of a UUID
    condition        = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message    = "The user_uuid value is not a valid UUID."
  }
}