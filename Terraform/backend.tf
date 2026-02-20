terraform {
  backend "s3" {
    bucket         = "terraform-state-lara-project1"
    key            = "project1/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks-lara"
    encrypt        = true
  }
}