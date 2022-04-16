provider "aws" {
  region                  = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.10.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state"
    key            = "ia/test/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

resource "aws_lambda_function" "l_function" {
  function_name = "IATest"
  role          = "arn:aws:iam::xxxx"
  timeout       = 900
  memory_size   = 6144
  package_type  = "Image"
  image_uri     = "xxxx.dkr.ecr.us-east-1.amazonaws.com/ia:test"
}

resource "aws_lambda_permission" "l_permission" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.l_function.arn
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::ia-data"

  depends_on = [aws_lambda_function.l_function]
}

resource "aws_s3_bucket_notification" "s3_trigger" {
  bucket = "ia-data"

  lambda_function {
    lambda_function_arn = aws_lambda_function.l_function.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "test/"
    filter_suffix       = ".png"
  }

  depends_on = [aws_lambda_permission.l_permission]
}

resource "aws_lambda_function_event_invoke_config" "sqs_destination" {
  function_name = aws_lambda_function.l_function.arn

  destination_config {
    on_failure {
      destination = "arn:aws:sqs:us-east-1:xxxx:IATest"
    }
  }
}