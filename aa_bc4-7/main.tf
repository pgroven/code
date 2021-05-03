#This module is required for all enviornments, do not delete
module "gvars" {
  source = "../../../../../../modules/aws/global/vars"

  environment = "${terraform.workspace}"
}

#############Data resourcest to pull vpc_id and subnets_ids############################

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "${var.terraform_remote_state_bucket["${terraform.workspace}"]}"
    key    = "${var.terraform_remote_state_key["${terraform.workspace}"]}"
    region = "${var.region["${terraform.workspace}"]}"
  }
}


####################Creating security_groups##########################################
module "security_group" {
  source                     = "../../../../../../modules/aws/network/security-groups"
  security-group-name        = "automationanywhere-aa-bc-qa-${terraform.workspace}"
  security-group-description = "SG to be applied sepcified automateanywhere resourcess"
  vpc-id                     = "${data.terraform_remote_state.network.vpc_id}"
  ingress                    = "${var.ingress}"

  #### SET-12099 Inserted governance required tags ####
  tag_application_key        = "1099"
  tag_module_key             = "rpa_aa_bot_creator"
  tag_created_by             = "Sprinters@phoenix.edu"
}


#############################Data for reading ami_id mani updated this on 09/17/2019 10.19AM#################################

data "aws_ami" "automateanywhere" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["801119661308"] # Canonical
}

###############################Creating  EC2_instance with above AMI##########################

module "aws_instance" {
 source = "../../../../../../modules/aws/compute/ec2"

  instance_count                = "${var.instance_count}"
  ami_id                        = "${data.aws_ami.automateanywhere.id}"
  instance_type                 = "${var.instance_type}"

  #### SET-12099 Error: module "aws_instance": "instance_tags" is not a valid argument ####
  # instance_tags                 = "${var.instance_tags}-${terraform.workspace}"

  key_name                      = "${var.key_name}"
  associate_public_ip_address   = "${var.associate_public_ip_address}"
  monitoring                    = "${var.monitoring}"
  vpc_security_group_ids       = "${module.security_group.id}"
  subnet_id                     = "${split(",",data.terraform_remote_state.network.private_subnet_ids)}"
  root_volume_size              = "${var.root_volume_size}"
  delete_on_termination         = "true"
  create_before_destroy         = "false"

  #### SET-12099 Error: module "aws_instance": "environment" is not a valid argument ####
  # environment                   = "${terraform.workspace}"
  #### SET-12099 Error: module "aws_instance": "application" is not a valid argument ####
  # application                   = "automateanywhere"

  #ebs_block_device              = "${var.ebs_block_device}"

  #### SET-12099 Error: module "aws_instance": "module_key" is not a valid argument ####
  # module_key                    = "aa"
  #### SET-12099 Error: module "aws_instance": "application_key" is not a valid argument ####
  # application_key               = "bot-creator-qa"
  #### SET-12099 Error: module "aws_instance": "created_by" is not a valid argument ####
  # created_by                    = "foofighters"
  #### SET-12099 Error: module "aws_instance": "tags" is not a valid argument ####
  # tags                          = "${var.tags}"

 user_data                      = <<EOF
  <powershell>
start-transcript -path c:\windows\temp\serverbuild.log
C:\\ProgramData\\Amazon\\EC2-Windows\\Launch\\Scripts\\InitializeInstance.ps1 -Schedule
${file("domain-join.ps1")}
sleep 120
stop-transcript
</powershell>
EOF

 #### SET-12099 Inserted governance required tags ####
  tag_application_key          = "1099"
  tag_module_key               = "rpa_aa_bot_creator"
  tag_created_by               = "Sprinters@phoenix.edu"

  #### SET-12099 Updated due to module changes from previous commented tags ####
  ApplicationKey               = "1099"
  ModuleKey                    = "rpa_aa_bot_creator"
  CreatedBy                    = "Sprinters@phoenix.edu"
}