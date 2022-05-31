provider "aws" {
  region                  = "us-east-1"
}

provider "aws" {
  alias                   = "west"
  region                  = "us-west-2"
}

terraform {
  backend "s3" {
    profile = "linuxtips-terraform"
    bucket  = "descomplicando-terraform-fabio-bartoli"
    #dynamodb_table = "terraform-state-lock-dynamo"
    key     = "terraform-test.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

  required_providers {
    aws = {
      version = "~> 3.0"
      source  = "hashicorp/aws"
    }
  }
}