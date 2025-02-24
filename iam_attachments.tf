# Contains all policy attachments
resource "aws_iam_role_policy_attachment" "bedrock_policy_attachment" {
  role       = aws_iam_role.bedrock_role.name
  policy_arn = aws_iam_policy.bedrock_policy.arn
}

resource "aws_iam_user_policy_attachment" "user_assume_role" {
  user       = aws_iam_user.bedrock_user.name
  policy_arn = aws_iam_policy.assume_role_policy.arn
}