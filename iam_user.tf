resource "aws_iam_user" "bedrock_user" {
  name = var.user_name
  path = "/"
  
  tags = {
    Description = "User for Bedrock access"
    Environment = var.environment
  }
}

resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.bedrock_user.name
}