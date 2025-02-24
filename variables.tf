variable "environment" {
  description = "Environment name (e.g., development, production)"
  type        = string
  default     = "development"
}

variable "user_name" {
  description = "Name of the IAM user to create"
  type        = string
  default     = "alvin"
}