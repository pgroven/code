############# Do not modify the below ###############

variable "region" {
  type        = "map"
  description = "aws region"
}
variable "terraform_remote_state_bucket" {
  type        = "map"
  description = "network stuff"
}
variable "terraform_remote_state_key" {
  type        = "map"
  description = "unlock stuff"
}

##########variables for EC2_Instance#################################

variable "ami_id" {}

variable "instance_type" {
default = "t2.xlarge"
}

variable "root_volume_size" {
}

variable "associate_public_ip_address" {
 
}

variable "key_name" {
  description = "Name of key already loaded into AWS region"
  default = "tools"
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
}


variable "subnet_id" {
  type = "list"
}

variable "instance_tags" { }
variable "instance_count" {}

//variable "vpc_security_group_ids" {}

variable "create_before_destroy" {}
variable "delete_on_termination" {}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = "map"
  default = {}
}

variable "availability_zone" {
  type = "map"
}
variable "ebs_block_device" {
  type = "list"
}
