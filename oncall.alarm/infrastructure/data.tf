# Retrieve infra sandbox vpc and subnet ids

# VPC id
data "aws_vpc" "sandbox_vpc" {
  id = var.vpc_id
}


# Private subnet ids
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.sandbox_vpc.id]
  }

  tags = {
    Tier = "Private"
  }
}

data "aws_subnet" "private" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}


# Public subnet ids
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.sandbox_vpc.id]
  }

  tags = {
    Tier = "Public"
  }
}

data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.public.ids)
  id       = each.value
}