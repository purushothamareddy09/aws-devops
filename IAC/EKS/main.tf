terraform {
  backend "s3" {
    bucket         = var.tf_state_bucket
    key            = "eks/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.tf_state_bucket

  lifecycle {
    prevent_destroy = true
  }
}