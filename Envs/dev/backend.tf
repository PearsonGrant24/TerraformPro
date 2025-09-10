terraform {
  
  backend "s3" {
    bucket = "pract-terraform-122347"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
    
  }
}