locals {

  common_tags = {
    application       = "${var.app_name}"
    environment       = "${var.environment}"
    owner             = "${var.owner}"
    region            = "${var.region}"
  }

  private_subnet_ids = [for s in data.aws_subnet.private : s.id]
  public_subnet_ids  = [for s in data.aws_subnet.public : s.id]

}