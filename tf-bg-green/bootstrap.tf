provider "aws" {
  region = "eu-west-2"
}

# TBD --- dynamodb state lock
# CMD: aws s3 mb s3://bg-tfstate-1675 --region eu-west-2
terraform {
  backend "s3" {
    encrypt = true
    bucket  = "bg-tfstate-1675"
    region  = "eu-west-2"
    key     = "v2"
  }
}
