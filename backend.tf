terraform {
  backend "s3" {
    bucket         = "my-new-bucket-355057"
    key            = "goutham/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
