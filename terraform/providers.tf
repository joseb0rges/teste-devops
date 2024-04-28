terraform {
  required_version = ">= 0.13"
}

provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket  = "s3-coodesh-terraform-state"
    key     = "coodesh/dev.tfstate"
    region  = "us-east-1"
    encrypt = true
   
  }
}
