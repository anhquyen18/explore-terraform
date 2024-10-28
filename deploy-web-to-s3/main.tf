provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "static" {
  bucket        = "anhquyen-180900"
  force_destroy = true
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_website_configuration" "static" {
  bucket = aws_s3_bucket.static.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

resource "aws_s3_bucket_policy" "static" {
  bucket = aws_s3_bucket.static.id
  policy = file("iam/s3_static_policy.json")
}


resource "aws_s3_bucket_public_access_block" "static" {
  bucket = aws_s3_bucket.static.id

  # block_public_acls       = false
  # block_public_policy     = false
  # ignore_public_acls      = false
  # restrict_public_buckets = false
}


locals {
  mime_types = {
    html  = "text/html"
    css   = "text/css"
    ttf   = "font/ttf"
    woff  = "font/woff"
    woff2 = "font/woff2"
    js    = "application/javascript"
    map   = "application/javascript"
    json  = "application/json"
    jpg   = "image/jpeg"
    png   = "image/png"
    svg   = "image/svg+xml"
    eot   = "application/vnd.ms-fontobject"
  }
}

resource "aws_s3_object" "object" {
  for_each     = fileset(path.module, "resources/static-web-main/**/*")
  source       = each.value
  bucket       = aws_s3_bucket.static.id
  key          = replace(each.value, "resources/static-web-main", "")
  etag         = filemd5("${each.value}")
  content_type = lookup(local.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}
