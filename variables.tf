variable "public_instance" {
  description = "Number of public EC2 instances to create"
  type        = number
}
variable "pub_sub_count" {
  description = "Number of public subnets"
  type        = number
}

variable "priv_sub_count" {
  description = "Number of private subnets"
  type        = number
}

variable "nat_count" {
  description = "Number of NAT gateways"
  type        = number
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "instance_id" {
description = "Instance ID we want to stop and start"
type = list(string)
}

variable "instance_stop_time"{
description = " The time instance need to be stopped"
type = string
}
variable "instance_start_time" {
description = " The time instance need to be start"
type = string
}