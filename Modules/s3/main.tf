resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name

  tags = {
    Name = "pract-dev-website"
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
    bucket = aws_s3_bucket.s3.bucket

    index_document {
      suffix = "/index.html"
    }  
}