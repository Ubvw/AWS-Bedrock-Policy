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
          "bedrock:GetFoundationModel",
          "bedrock:GetFoundationModelAvailability",
          "bedrock:ListInferenceProfiles"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "assume_role_policy" {
  name        = "allow-assume-bedrock-role"
  description = "Policy allowing assumption of the Bedrock role"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Resource = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/bedrock-assume-role"
      }
    ]
  })
}