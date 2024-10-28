resource "aws_dynamodb_table" "dynamodb_table" {
  name     = "${var.project}-s3-project"
  hash_key = "LockID"

  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}
