# Lambda function

resource "aws_lambda_function" "lambda_alarm" {
  s3_bucket     = var.backend_bucket
  s3_key        = "${var.environment}/${var.app_name}/code/lambda.zip"
  function_name = "${var.environment}-${var.app_name}-lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "oncall_alarm.lambda_handler"
  runtime       = "python3.9"
  
  vpc_config {
    security_group_ids = [aws_security_group.lambda_sg.id]
    subnet_ids         = [local.private_subnet_ids[0], local.private_subnet_ids[1]]
  }

  environment {
    variables = {
      LINK     = var.link
      ROLE_ARN = aws_iam_role.lambda_role.arn
      SNS_ARN  = aws_sns_topic.oncall_topic.arn
    }
  }
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_alarm.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cloudwatch_rule.arn
}