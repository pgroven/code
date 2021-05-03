
terraform {
  backend "s3" {
    bucket = "apollo-terraform-state-us-east-1"
    region = "us-east-1"

  #  dynamodb_table = "apollo-terraform-state-lock-us-east-1"
    #############################

    #must be a unique path, (where possible please follow folder structure)
    key     = "apps/automateanywhere/aa_nonprod_qa/aa_bc_4_5/terraform.tfstate"
    encrypt = "true"
  }
}