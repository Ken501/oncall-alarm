# DynamoDB Table

resource "aws_dynamodb_table" "oncall_table" {
  name      = "${var.environment}-${var.app_name}-table"
  hash_key  = "${var.hash_key}"
  range_key = "${var.range_key}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "${var.hash_key}"
    type = "N"
  }

    attribute {
    name = "${var.range_key}"
    type = "N"
  }

}

# DynamoDB Items

resource "aws_dynamodb_table_item" "index_0" {
  table_name = aws_dynamodb_table.oncall_table.name
  hash_key  = "${var.hash_key}"
  range_key = "${var.range_key}"
  item = <<ITEM
{
  "${var.hash_key}": {"N": "0"},
  "${var.range_key}": {"N": "0"},
  "index_value": {"N": "1"}
}
ITEM

}

resource "aws_dynamodb_table_item" "index_1" {
  table_name = aws_dynamodb_table.oncall_table.name
  hash_key  = "${var.hash_key}"
  range_key = "${var.range_key}"
  item = <<ITEM
{
  "${var.hash_key}": {"N": "1"},
  "${var.range_key}": {"N": "1"},
  "user": {"S": "${var.user1}"},
  "email": {"S": "${var.email1}"}
}
ITEM

}

resource "aws_dynamodb_table_item" "index_2" {
  table_name = aws_dynamodb_table.oncall_table.name
  hash_key  = "${var.hash_key}"
  range_key = "${var.range_key}"
  item = <<ITEM
{
  "${var.hash_key}": {"N": "2"},
  "${var.range_key}": {"N": "2"},
  "user": {"S": "${var.user2}"},
  "email": {"S": "${var.email2}"}
}
ITEM

}

resource "aws_dynamodb_table_item" "index_3" {
  table_name = aws_dynamodb_table.oncall_table.name
  hash_key  = "${var.hash_key}"
  range_key = "${var.range_key}"
  item = <<ITEM
{
  "${var.hash_key}": {"N": "3"},
  "${var.range_key}": {"N": "3"},
  "user": {"S": "${var.user3}"},
  "email": {"S": "${var.email3}"}
}
ITEM

}