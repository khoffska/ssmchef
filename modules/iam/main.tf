resource "aws_iam_role" "ec2_ssm_role" {
  name               = var.role_name
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.ec2_ssm_role.name
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = var.ssm_policy_arn
}

resource "aws_iam_role_policy" "s3_get_policy" {
  name = "s3-get-policy"
  role = aws_iam_role.ec2_ssm_role.id

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "s3:GetObject",
        Resource = "*"
      }
    ]
  })
}
