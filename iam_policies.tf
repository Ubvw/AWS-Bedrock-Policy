resource "aws_iam_policy" "bedrock_policy" {
  name        = "bedrock-minimal-access"
  description = "Minimal access policy for AWS Bedrock"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "bedrock:InvokeModel",
          "bedrock:ListFoundationModels",
          "bedrock:GetModel",
          "bedrock:GetFoundationModel"
        ]
        Resource = "*"
      }
    ]
  })
}