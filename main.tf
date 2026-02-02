terraform {
  backend "s3" {
    bucket         = "state-terraform-20260202-purushothamareddy10744"
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "state-terraform-20260202-purushothamareddy10744"

  lifecycle {
    prevent_destroy = true
  }
}