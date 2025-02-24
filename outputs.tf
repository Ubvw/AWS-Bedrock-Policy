output "bedrock_role_arn" {
  value       = aws_iam_role.bedrock_role.arn
  description = "ARN of the created IAM role for Bedrock access"
}

output "user_access_key_id" {
  value       = aws_iam_access_key.user_key.id
  description = "Access key ID for the user"
  sensitive   = false
}

output "user_secret_access_key" {
  value       = aws_iam_access_key.user_key.secret
  description = "Secret access key for the user"
  sensitive   = true
}