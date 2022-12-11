provider "aws" {
  region = "eu-west-3"
  access_key = "ALFKRIEOWSQRLDKSAQW"
  secret_key = "DDLDLWLWRKLRWKLRWFNQQOWE/12983QJWKJ139JEW932"
}

variable "subnet_cidr_block" {
  description = "subnet cidr block"
  # default = "10.0.10.0/20"
  type = list(string)
}

variable "environment" {
  description = "deployment environment"
}

resource "aws_vpc" "development-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name: var.environment
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "eu-west-3a"
  tags = {
    Name: "subnet-1-dev"
    vpc_env: "dev"
  }
}

output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}

# data "aws_vpc" "existing_vpc" {
#   default = true
# }

# resource "aws_subnet" "dev-subnet-2" {
#   vpc_id = data.aws_vpc.existing_vpc.id
#   cidr_block = "172.31.48.0/20"
#   availability_zone = "eu-west-3a"
#   tags = {
#     Name: "subnet-2-default"
#   }
# }
