resource "aws_s3_bucket" "s3_pre_pro" {
  bucket        = "explore-terraform-s3-pre-pro-aq"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "s3_pre_pro" {
  bucket = aws_s3_bucket.s3_pro.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_website_configuration" "s3_pre_pro" {
  bucket = aws_s3_bucket.s3_pre_pro.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

data "aws_iam_policy_document" "s3_pre_pro" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_pre_pro.arn}/*"]

    principals {
      type = "AWS"
      identifiers = [
        aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_pre_pro" {
  bucket = aws_s3_bucket.s3_pre_pro.id
  policy = data.aws_iam_policy_document.s3_pre_pro.json
}
