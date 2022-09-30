# Subnet Outputs

output "private_subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.private : s.cidr_block]
}

output "public_subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.public : s.cidr_block]
}