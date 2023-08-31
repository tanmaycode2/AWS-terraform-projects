terraform {

required_version = ">= 0.14.0"
backend "s3" {
  bucket = "ts-dev-terraform-state"
  key    = "terraform.tfstate"
  region = "us-east-1"
 }
}