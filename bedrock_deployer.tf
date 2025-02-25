#################
# User creation #
#################

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


##############
# IAM Roles  #
##############

resource "aws_iam_role" "bedrock_role" {
  name = "bedrock-assume-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/alvin"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}


##########################
# IAM Policy definitions #
##########################

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


##################################
# Contains all policy attachments#
##################################

resource "aws_iam_role_policy_attachment" "bedrock_policy_attachment" {
  role       = aws_iam_role.bedrock_role.name
  policy_arn = aws_iam_policy.bedrock_policy.arn
}

resource "aws_iam_user_policy_attachment" "user_assume_role" {
  user       = aws_iam_user.bedrock_user.name
  policy_arn = aws_iam_policy.assume_role_policy.arn
}

resource "aws_iam_role_policy_attachment" "s3_full_access_attachment" {
  role       = aws_iam_role.bedrock_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


##############
# Variables  #
##############

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


#################
# Output values #
#################

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

# Used to get the AWS account ID
data "aws_caller_identity" "current" {}