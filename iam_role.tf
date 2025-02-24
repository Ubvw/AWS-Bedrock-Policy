resource "aws_iam_role" "bedrock_role" {
  name = "bedrock-assume-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_user.bedrock_user.arn
        }
        Action = "sts:AssumeRole"
        Condition = {
          Bool = {
            "aws:MultiFactorAuthPresent": "true"
          }
        }
      }
    ]
  })
}