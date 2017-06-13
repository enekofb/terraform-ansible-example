variable "zone_count" {
  default = "1"
}

variable "eu-west-availablity-zone"{
  default = {
    "0" = "eu-west-1a"
  }
}

variable "public_subnet_cidr_block"{
  default = {
    "0" = "10.20.1.0/24"
  }
}


variable "private_subnet_cidr_block"{
  default = {
    "0" = "10.20.10.0/24"
  }
}

variable "access_key" {}
variable "secret_key" {}
variable "public_key" {}

variable "region" {
  default = "eu-west-1"
}
