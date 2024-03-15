// public_subnet/main.tf

provider "aws" {
  region = "us-east-1"
}

variable "vpc_id" {}
variable "vpc_cidr" {}

resource "aws_subnet" "public" {
  count           = 4
  vpc_id          = var.vpc_id
  cidr_block      = cidrsubnet(var.vpc_cidr, 8, count.index)
  map_public_ip_on_launch = true
}

output "subnet_ids" {
  value = aws_subnet.public[*].id
}
