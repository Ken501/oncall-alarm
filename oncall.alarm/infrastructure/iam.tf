# Lambda function IAM role

resource "aws_iam_role" "lambda_role" {
  name = "${var.environment}-${var.app_name}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Policies

resource "aws_iam_policy" "lambda_basic_policy" {
  name        = "${var.environment}-${var.app_name}-lambda-basic-policy"
  path        = "/"
  description = "Lambda-basic-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:logs:us-east-1:382920669747:log-group:/aws/lambda/${var.environment}-${var.app_name}:*"
          ]
      },
      {
        Action = [
          "logs:CreateLogGroup"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:logs:us-east-1:382920669747:*"
          ]
      },
    ]
  })
}

resource "aws_iam_policy" "publish_policy" {
  name        = "${var.environment}-${var.app_name}-sns-publish-policy"
  path        = "/"
  description = "sns-publish-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sns:Publish",
        ]
        Effect   = "Allow"
        Resource = [
          "${aws_sns_topic.oncall_topic.arn}"
          ]
      },
    ]
  })
}

resource "aws_iam_policy" "vpc_policy" {
  name        = "${var.environment}-${var.app_name}-vpc-access-policy"
  path        = "/"
  description = "vpc-access-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeNetworkInterfaces"
        ]
        Effect   = "Allow"
        Resource = [
          "*"
          ]
      },
    ]
  })
}

# Attach policies Lambda role policies

resource "aws_iam_policy_attachment" "AWSLambdaBasicExecutionRole" {
  name       = "AWSLambdaBasicExecutionRole-6023ab8e-b9eb-4c5c-a8ae-a20c4c27d3b9"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = aws_iam_policy.lambda_basic_policy.arn
}

resource "aws_iam_policy_attachment" "AWSLambdaSNSPublishPolicyExecutionRole" {
  name       = "AWSLambdaSNSPublishPolicyExecutionRole-88c3a102-8920-471f-9a0b-c4dba53fd1bc"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = aws_iam_policy.publish_policy.arn
}

resource "aws_iam_policy_attachment" "AWSLambdaVPCAccessExecutionRole" {
  name       = "AWSLambdaVPCAccessExecutionRole-8af8329b-504d-41bf-aef8-c62ea36f32f6"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = aws_iam_policy.vpc_policy.arn
}

resource "aws_iam_policy_attachment" "AmazonDynamoDBFullAccess" {
  name       = "AmazonDynamoDBFullAccess"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}