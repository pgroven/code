terraform {
  backend "s3" {
    bucket         = "uop-terraform-sample-state-us-west-2"
    key            = "apps/sqldr/terraform.tfstate"
    region         = "us-west-2"
    profile        = "default"
    dynamodb_table = "oracle_ec2"
    encrypt        = "true"
  }
}
