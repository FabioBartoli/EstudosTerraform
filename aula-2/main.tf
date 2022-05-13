provider "aws" {
  profile = "linuxtips-terraform"
  shared_credentials_file = "~/.aws/credentials"
  region  = "us-east-1"
  version = "~> 3.0"
}

provider "aws" {
  alias = "west"
  region  = "us-west-2"
  version = "~> 3.0"
  profile = "linuxtips-terraform"
  shared_credentials_file = "~/.aws/credentials"
}

terraform {
  backend "s3" {
    profile = "linuxtips-terraform"
    bucket = "descomplicando-terraform-fabio-bartoli"
    #dynamodb_table = "terraform-state-lock-dynamo"
    key    = "terraform-test.tfstate"
    region = "us-east-1"
  }
}