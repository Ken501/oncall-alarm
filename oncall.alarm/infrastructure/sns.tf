# SNS

resource "aws_sns_topic" "oncall_topic" {
  name = "${var.environment}-${var.app_name}-topic"
}

# SNS topic subscribtions

resource "aws_sns_topic_subscription" "oncall_subscribtion_user1" {
  endpoint  = "${var.email1}"
  protocol  = "email"
  topic_arn = aws_sns_topic.oncall_topic.arn
}

resource "aws_sns_topic_subscription" "oncall_subscribtion_user2" {
  endpoint  = "${var.email2}"
  protocol  = "email"
  topic_arn = aws_sns_topic.oncall_topic.arn
}

resource "aws_sns_topic_subscription" "oncall_subscribtion_user3" {
  endpoint  = "${var.email3}"
  protocol  = "email"
  topic_arn = aws_sns_topic.oncall_topic.arn
}