resource "aws_kms_key" "tf_bucket_key" {
  description             = "Encryption key for bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  is_enabled              = true
  multi_region            = false
}

resource "aws_kms_alias" "key_alias" {
  name          = "alias/tf-bucket-key"
  target_key_id = aws_kms_key.tf_bucket_key.key_id
}

resource "random_id" "this" {
  byte_length = 4
}
resource "aws_s3_bucket" "tf_bucket" {
  bucket = "tf-backend-state-${random_id.this.hex}"
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.tf_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "tf_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.this]
  bucket     = aws_s3_bucket.tf_bucket.id
  acl        = "private"
}

resource "aws_s3_bucket_versioning" "tf_bucket_versioning" {
  bucket = aws_s3_bucket.tf_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.tf_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.tf_bucket_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}