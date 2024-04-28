variable "vpc_cidr_block" {
  type = string
}

variable "public_subnets" {
  type = list(any)
}



variable "customer_group" {
  type = string
}

variable "env" {}


variable "tags" {
  description = "AWS Tagging"
  type        = map(string)
  default = {}
}

locals {
  tags = merge(
    var.tags,
    {
    "Environment"   = "${var.env}"
    "CreatedBy"     = "terraform"
    },
  )
}