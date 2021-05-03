
# Do not modify this file
provider "aws" {
  region = "${var.region["${terraform.workspace}"]}"

  assume_role {
    role_arn = "arn:aws:iam::${module.gvars.account}:role/platform_services_role"
  }
}
