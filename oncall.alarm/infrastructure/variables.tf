variable "environment" {
  description = "Resource lifecycle"
}

variable "app_name" {
  description = "Name of application or service"
}

variable "owner" {
  description = "App owner"
}

variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
}

variable "access_key" {
  description = "AWS Access Key"
}

variable "secret_key" {
  description = "AWS Secret Key"
}

variable "vpc_id" {
  description = "AWS Sandbox VPC"
  default = "vpc-cc1b89b4"
}

variable "backend_bucket" {
  description = "Terraform backend for tf.state files"
  default = "wdrx-sandbox-deployments"
}

variable "link" {
  description = "Oncall re-direct link"
  default = "https://tpaappp66.welldynerx.com/ucmuser/main#callforwarding"
}

variable "hash_key" {
  description = "DynamoDB partition key"
  default = "index"
}

variable "range_key" {
  description = "DynamoDB range key"
  default = "turn"
}

variable "user1" {
  description = "User for item 1"
}

variable "email1" {
  description = "Email for item 1"
}

variable "user2" {
  description = "User for item 2"
}

variable "email2" {
  description = "Email for item 2"
}

variable "user3" {
  description = "User for item 3"
}

variable "email3" {
  description = "Email for item 3"
}