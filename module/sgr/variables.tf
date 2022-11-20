variable "owner" {
  default = "arthurk"
}

variable "vpc_id" {}

variable "sgr_web_ports" {
  default = ["80", "443", "10051"]
}

variable "ssh_source_ip" {
  default = ["0.0.0.0/0"]
}


