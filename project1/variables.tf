variable "region" {
  default = "eu-west-3"

}

variable "owner" {
  default = "arthurk"

}

variable "web_server_instance_type" {
  default = "t2.medium"
}


variable "rdp_windows_srv_instance_type" {
  default = "t2.medium"
}

variable "source_ip" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
