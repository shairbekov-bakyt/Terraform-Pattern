provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "usersTable" {
  name     = "Users"
  hash_key = "UserId"
  read_capacity = 1
  write_capacity = 1
  attribute {
    name = "UserId"
    type = "N"
  }
}