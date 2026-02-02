terraform {
  backend "s3" {
    bucket         = "state"
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "state"

  lifecycle {
    prevent_destroy = true
  }
}