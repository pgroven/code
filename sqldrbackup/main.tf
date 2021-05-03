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

resource "aws_security_group" "sqldr" {
  name_prefix = "sqldr-sg-${terraform.workspace}"
  description = "SG to be applied specific database resources"
  vpc_id      = "${data.terraform_remote_state.network.vpc_id}"


ingress {

    # What's Connecting: RDP from local machines | Usage: RDP
    from_port = 3389
    to_port   = 3389
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  }



  ingress {

    # What's Connecting: RDP from local machines | Usage: RDP
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  }


  ingress {

    # What's Connecting  HTTP status page | Usage: HTTP
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  }


  ingress {

    # What's Connecting  Web browsers Bot Runners Bot Creators | Usage: HTTPS and WebSocket


    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  ingress {

     # What's Connecting  Microsoft SQL Server  Replication Connection Port
     # Usage : Microsoft SQL Server


    from_port = 8433
    to_port   = 8440
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  }


  ingress {

     # What's Connecting Micorsoft SQL Replication Port


    from_port = 5022
    to_port   = 5022
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  }



  ingress {

    # What's Connecting Microsoft Netbios Port


    from_port = 139
    to_port   =  139
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  }


  ingress {

    # What's Connecting 


    from_port =  445
    to_port   = 445
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  }


  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

#############################Data for reading ami_id mani updated this on 09/17/2019 10.19AM#################################
###################################### Test Phil Groven #########################################
data "aws_ami" "sqldr" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base-2019.08.16"]
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

    tags          = {
    application_key        = "sqldr"
    created_by = "Touch of Grey"
    module_key = "aa"
  }


}

###############################Creating  EC2_instance with above AMI##########################

module "aws_instance" {
  source = "../../../../../../modules/aws/compute/ec2"

  //source           = "../../../../../../modules/aws/compute/launchconfig_with_asg"
  instance_count              = "${var.instance_count}"
  ami_id                      = "${data.aws_ami.sqldr.id}"
  instance_type               = "${var.instance_type}"
  instance_tags               = "${var.instance_tags}-${terraform.workspace}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  monitoring                  = "${var.monitoring}"
  vpc_security_group_ids      = "${aws_security_group.sqldr.id}"

  //subnet_id                   = "${data.terraform_remote_state.network.private_subnet_ids_list}"
  subnet_id             = "${var.subnet_id}"
  root_volume_size      = "${var.root_volume_size}"
  delete_on_termination = "true"
  create_before_destroy = "true"
  environment           = "${terraform.workspace}"
  application          = "sql-dr"
  tags                  = "${var.tags}"
 #ebs_block_device = "${var. ebs_block_device}"

  user_data             = <<EOF
  <powershell>
start-transcript -path c:\windows\temp\serverbuild.log
C:\\ProgramData\\Amazon\\EC2-Windows\\Launch\\Scripts\\InitializeInstance.ps1 -Schedule
${file("${path.module}/domain-join.ps1")}
sleep 120
stop-transcript
</powershell>
EOF
}