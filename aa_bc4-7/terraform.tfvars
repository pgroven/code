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
 
instance_count               = "4"
ami_id                      = "ami-0315d99b2650530ea"
instance_type               = "t2.xlarge"
key_name                    = "RPA_AA_FF"
instance_tags               = "automateanywhere"
associate_public_ip_address = "false"
monitoring                  = "true"
certificate_arn_listener    = "arn:aws:acm:us-west-2:331956410237:certificate/ff18b8f8-924f-4a0a-b585-f4a8913825c5"
root_volume_size            = "260"
delete_on_termination       = "true"
create_before_destroy       = "true"

#############################alb############################

alb_name                         = "automateanywhere"
environment                      = "sandbox"
internal                         = "true"
enable_deletion_protection       = "false"
target_protocol                  = "HTTP"
vpc_id                           = "vpc-8adbf3e3"
protocol_listener                = "HTTP"
port_listener                    = "80"
target_port                      = "8000"
port                             = "8000"
protocol                         = "HTTP"
health_check_interval            = "30"
health_check_path                = "/automateanywhere"
health_check_timeout             = "10"
health_check_healthy_threshold   = "5"
health_check_unhealthy_threshold = "2"
matcher                          = "200,302"
stickiness_type                  = "lb_cookie"
stickiness_cookie_duration       = "3600"
stickiness_enabled               = "true"


#############################ebs_block_device############################

ebs_block_device = [
  
  {
    device_name = "/dev/sde"
    volume_size = 120
    volume_type = "gp2"
    delete_on_termination = true
}
  
]

availability_zone =  {
    sand = "us-west-2a"
    nonprod-st = "us-east-1a"
    nonprod-dev = "us-east-1a"
    mgmt-st = "us-east-1a"
    mgmt = "us-east-1a"
    prod = "us-east-1a"
}


#################Security Group############################################

ingress = [

 /* {
    # What's Connecting: RDP from local machines | Usage: RDP
    from_port         = 0
    to_port           = 0
    protocol          = -1
     security_groups  = ["sg-0ae6f0cefbd9c43c2"]
 
  },

  */
   {
    # What's Connecting: RDP from local machines | Usage: RDP
    from_port = 0
    to_port   = 0
    protocol  = -1

    cidr_blocks = [
      "10.113.0.0/16",
    ]
  },
  {
    # What's Connecting: RDP from local machines | Usage: RDP
    from_port = 3389
    to_port   = 3389
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  },
    {
    # What's Connecting: Client inbound  | Usage: Enterprise client required ports
    from_port = 943
    to_port   = 943
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  },
  {
 # What's Connecting: Client inbound  | Usage: Enterprise client required ports
    from_port = 4530
    to_port   = 4530
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  },

   {
    # What's Connecting: RDP from local machines | Usage: RDP
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  },


{
    # What's Connecting  Web browsers Bot Runners Bot Creators | Usage: HTTP
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  },


{
    # What's Connecting  Web browsers Bot Runners Bot Creators | Usage: HTTPS and WebSocket

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  },

 {
    # What's Connecting  nterprise Control Room Services Bot Insight services In this case, open the port on Microsoft SQL Server, not the Enterprise Control Room.  # Usage : Microsoft SQL Server

    from_port = 1433
    to_port   = 1433
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  },

{
    # What's Connecting Enterprise Control Room Services | Usage : Cluster Messaging

    from_port = 5672
    to_port   = 5672
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  },

{
    # What's Connecting Enterprise Control Room Services | Usage : Cluster Messaging and Caching

    from_port = 47500
    to_port   = 47600
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  },

{
    # What's Connecting Enterprise Control Room Services | Usage : Cluster Messaging and Caching

    from_port = 47100
    to_port   = 47200
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  },
{
    # What's Connecting: Open ports on both the Enterprise Control Room and the IQ Bot servers | Usage : Cluster Messaging and Caching

    from_port = 47100
    to_port   = 47200
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  },

{
    # What's Connecting :  Enterprise Control Room Services | Usage: Elasticsearch

    from_port = 47599
    to_port   = 47599
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  },

{
    # What's Connecting :  Enterprise Control Room Services | Usage: Elasticsearch
    from_port = 47600
    to_port   = 47600
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  },
  {
    # What's Connecting :  SCCM  | Usage: Software Management
    from_port = 7012
    to_port   = 7012
    protocol  = "tcp"
    protocol  = "udp"
    cidr_blocks = [
      "10.0.0.0/9",
    ]
  },
{
    # What's Connecting :  SCCM | Usage: Software management
    from_port = 2701
    to_port   = 2701
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/9",
    ]
  }
]