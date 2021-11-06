resource "aws_dynamodb_table" "LanguageScore" {
  hash_key       = "Language"
  name           = "LanguageScore-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "Language"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  tags = {
    Name        = "LanguageScore"
    Environment = "dev"
  }
}