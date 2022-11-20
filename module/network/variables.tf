variable "region" {
  default = "eu-west-3"
}

variable "vpc_cidr" {
  default = "10.0.0.0/20"
}

variable "owner" {
  default = "arthurk"
}

variable "public_subnet_cidrs" {
  default = [
    "10.0.0.0/24",
    "10.0.1.0/24"
  ]
}

variable "private_subnet_cidrs" {
  default = [
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}


