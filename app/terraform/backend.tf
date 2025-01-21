terraform {
  backend "s3" {
    bucket         = "mlops-detection-app-bucket"
    key            = "terraform/terraform.tfstate" # Prefix for Terraform state
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

resource "aws_s3_bucket_policy" "mlops_detection_app_bucket_policy" {
  bucket = "mlops-detection-app-bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "ELBAccessLogsPolicy",
        Effect    = "Allow",
        Principal = {
          Service = "elasticloadbalancing.amazonaws.com"
        },
        Action   = "s3:PutObject",
        Resource = "arn:aws:s3:::mlops-detection-app-bucket/*",
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = "713881828888"
          },
          ArnLike = {
            "aws:SourceArn" = "arn:aws:elasticloadbalancing:*:713881828888:loadbalancer/*"
          }
        }
      }
    ]
  })
}


