terraform {
  backend "s3"{
    bucket = "terraform-pract-1223346"
    keyb   =  "pract/terraform.tfstate"
    region = "us-east-1"
  }
}   