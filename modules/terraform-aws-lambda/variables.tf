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