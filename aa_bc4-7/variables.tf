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

variable "instance_type" {}

variable "root_volume_size" {}

variable "associate_public_ip_address" {}

variable "key_name" {
  description = "Name of key already loaded into AWS region"
  default     = ""
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
}
/*
variable "subnet_id" {
  type = "list"
}

*/
variable "instance_tags" {}
variable "instance_count" {}

//variable "vpc_security_group_ids" {}

variable "create_before_destroy" {}
variable "delete_on_termination" {}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = "map"
  default     = {}
}

variable "availability_zone" {
  type = "map"
}

variable "ingress" {
  type = "list"
}

########################Vars for ELB ########################################

variable "vpc_id" {
  description = "ID of the VPC to create the security group in"
}

variable "certificate_arn_listener" {}
variable "alb_name" {}

variable "internal" {
  description = "(Optional) If true, the LB will be internal."
}

variable "enable_deletion_protection" {
  description = "(Optional) If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
  default     = false
}

/*
variable "subnets" {
  type = "list"
}

*/
variable "target_port" {}

variable "target_protocol" {}

variable "port_listener" {
  description = "(Required) The port on which the load balancer is listening."
}

variable "protocol_listener" {
  description = "- (Optional) The protocol for connections from clients to the load balancer. Valid values are TCP, TLS, HTTP and HTTPS. Defaults to HTTP."
}

variable "redirect" {
  description = "Boolean that decides whether the ALB has a port 80 redirect"
  default     = false
}

variable "ebs_block_device" {
  type = "list"
}

//health_check

variable "protocol" {}

variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of each server. Minimum value 5 seconds, Maximum value 300 seconds."
  default     = "30"
}

variable "health_check_path" {
  description = "The path to use for health check requests."
  type        = "string"
}

variable "health_check_timeout" {
  description = "The amount of time, in seconds, during which no response from a server means a failed health check. Must be between 2 and 60 seconds."
  default     = "5"
}

variable "health_check_healthy_threshold" {
  description = "The number of times the health check must pass before a server is considered healthy."
  default     = "5"
}

variable "health_check_unhealthy_threshold" {
  description = "The number of times the health check must fail before a server is considered unhealthy."
  default     = "2"
}

variable "health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a server. You can specify multiple comma-separated values (for example, \"200,202\") or a range of values (for example, \"200-299\")."
  type        = "string"
  default     = "200,302"
}

variable "port" {}

variable "matcher" {}

variable "environment" {}

variable "stickiness_type" {}

variable "stickiness_cookie_duration" {}

variable "stickiness_enabled" {}

