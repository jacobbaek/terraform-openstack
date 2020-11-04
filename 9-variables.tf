variable "image_name" {
  default = "centos"
}

variable "ssh-pubkey" {
  default = "ssh-rsa "
}

variable "public_network" {
  default = "external-network"
}

variable "nat_network" {
  default = "internal-network"
}
