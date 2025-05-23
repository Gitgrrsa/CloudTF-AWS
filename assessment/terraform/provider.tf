provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "your-tfstate-bucket"
    key    = "defensepoint/terraform.tfstate"
    region = "us-east-1"
  }
}
