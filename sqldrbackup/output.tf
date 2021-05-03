
output "sg_id" {
  value = "${aws_security_group.sqldr.id}"
}

output "ami_id" {
  value = "${data.aws_ami.sqldr.id}"
}


output "vpc_id" {
   value =  "${data.terraform_remote_state.network.vpc_id}"
}

output "id" {
  value = "${module.aws_instance.id}"
}



