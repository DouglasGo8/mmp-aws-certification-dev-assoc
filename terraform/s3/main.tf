resource "aws_s3_bucket" "my_xpto_bucket_dougdb" {

  bucket = "mycamelpawbucket"

  #cors_rule {
  #  allowed_methods = ["GET"]
  #  allowed_origins = ["*"]
  #}

  force_destroy = false



  tags = {
    Name        = "My Camel Paw Bucket"
    Environment = "Dev"
  }

}


# aws_s3_bucket_public_access_block