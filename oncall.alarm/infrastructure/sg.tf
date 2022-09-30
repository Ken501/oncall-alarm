# Security groups

# Lambda Security group

resource "aws_security_group" "lambda_sg" {
  name        = "${var.environment}-${var.app_name}-lambda"
  description = "Allow ICMP  inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "ICMP"
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["10.10.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lambda"
  }
}