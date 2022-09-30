resource "aws_cloudwatch_event_rule" "cloudwatch_rule" {
  name = "${var.environment}-${var.app_name}-event"
  schedule_expression = "cron(00 13 ? * 2 *)"
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule = aws_cloudwatch_event_rule.cloudwatch_rule.name
  arn  = aws_lambda_function.lambda_alarm.arn
}