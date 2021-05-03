//General variables

############# Do not modify the below ###############
region = {
  prod        = "us-east-1"
  nonprod-st  = "us-east-1"
  nonprod-dev = "us-east-1"
  mgmt        = "us-east-1"
  mgmt-st     = "us-east-1"
  sand        = "us-west-2"
}

terraform_remote_state_bucket = {
  prod        = "apollo-terraform-state-us-east-1"
  nonprod-st  = "apollo-terraform-state-us-east-1"
  nonprod-dev = "apollo-terraform-state-us-east-1"
  mgmt        = "apollo-terraform-state-us-east-1"
  mgmt-st     = "apollo-terraform-state-us-east-1"
  sand        = "uop-terraform-sample-state-us-west-2"
}

terraform_remote_state_key = {
  prod        = "us_east_1_prod/prod/network/terraform.tfstate"
  nonprod-st  = "us_east_1_nonprod/systest/network/terraform.tfstate"
  nonprod-dev = "us_east_1_nonprod/dev/network/terraform.tfstate"
  mgmt        = "us_east_1_management/network/terraform.tfstate"
  mgmt-st     = "us_east_1_management/network/terraform.tfstate"
  sand        = "network/network/terraform.tfstate"
}


###############EC2 instance_values############################
 
instance_count               = "1"
ami_id                      = "ami-274ba847"
instance_type               = "t2.xlarge"
key_name                    = "tools"
instance_tags               = "sqldr"
associate_public_ip_address = "false"
monitoring                  = "true"

subnet_id                   = ["subnet-0af9de4e9e71b5415"]
root_volume_size            = "100"
delete_on_termination       = "true"
create_before_destroy       = "true"

availability_zone =  {
    sand = "us-west-2a"
    nonprod-st = "us-east-1a"
    nonprod-dev = "us-east-1a"
    mgmt-st = "us-east-1a"
    mgmt = "us-east-1a"
    prod = "us-east-1a"
}
ebs_block_device = [
  {
    device_name = "/dev/sdd"
    volume_size = 30
    volume_type = "gp2"
    delete_on_termination = true
 },
  {
    device_name = "/dev/sde"
    volume_size = 100
    volume_type = "gp2"
    delete_on_termination = true
},
   {
    device_name = "/dev/sdf"
    volume_size = 80
    volume_type = "gp2"
    delete_on_termination = true
  },
  {
    device_name = "/dev/sdg"
    volume_size = 40
    volume_type = "gp2"
    delete_on_termination = true
},
 {
    device_name = "/dev/sdh"
    volume_size = 40
    volume_type = "gp2"
    delete_on_termination = true
}
]