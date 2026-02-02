terraform {
  backend "s3" {
    bucket         = "state-terraform-apsouth1-20260202-purushothamareddy"
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "state-terraform-apsouth1-20260202-purushothamareddy"

  lifecycle {
    prevent_destroy = true
  }
}